#!/usr/bin/env bash
# Read-only preflight by default. --build calls the official builder
# in debug-only, no-install mode. ROM bytes never leave the local machine.
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="$(cd "$HERE/../.." && pwd)"
ROMS="${EMERALD_ROMS:-$HOME/Documents/gba_roms}"
BUILD=0
EXPECTED_FR_SHA1=ca666651374d89ca439007bed54d839eb7bd14d0

usage() {
    cat <<'HELP'
Usage: bash android_port/tools/preflight_fr.sh [--roms DIR] [--build]

Without --build: validate the local French ROM and toolchain without writes.
With --build: create the separate com.cer0.emerald.dev debug APK.
The script never installs an APK and never uses --release.
HELP
}
while (( $# )); do
    case "$1" in
        --roms) (( $# >= 2 )) || { echo 'FAIL: --roms needs a directory' >&2; exit 2; }; ROMS="$2"; shift 2 ;;
        --build) BUILD=1; shift ;;
        -h|--help) usage; exit 0 ;;
        *) echo "FAIL: unknown argument $1" >&2; exit 2 ;;
    esac
done

if [[ "$(uname -s)" != Linux ]]; then
    echo 'BLOCKED: Linux or WSL2 with Linux SDK/NDK required.' >&2
    exit 1
fi
if [[ ! -d "$ROMS" ]]; then
    echo "BLOCKED: no ROM directory: $ROMS" >&2
    exit 1
fi
ROM=""
while IFS= read -r -d '' candidate; do
    if [[ "$(sha1sum "$candidate" | cut -d ' ' -f1)" == "$EXPECTED_FR_SHA1" ]]; then
        ROM="$candidate"
        break
    fi
done < <(find "$ROMS" -maxdepth 1 -type f -iname '*.gba' -print0)
if [[ -z "$ROM" ]]; then
    echo "BLOCKED: clean French BPEF ROM not found (SHA-1 $EXPECTED_FR_SHA1)." >&2
    exit 1
fi
echo 'PASS: local French ROM SHA-1 (no ROM copied or uploaded).'

export DEVKITPRO="${DEVKITPRO:-/opt/devkitpro}"
export DEVKITARM="${DEVKITARM:-$DEVKITPRO/devkitARM}"
export PATH="$DEVKITPRO/tools/bin:$DEVKITARM/bin:$PATH"
missing=0
require_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "BLOCKED: missing command $1" >&2
        missing=1
    fi
}
require_executable() {
    if [[ ! -x "$1" ]]; then
        echo "BLOCKED: missing executable $1" >&2
        missing=1
    fi
}
for tool in git make gcc g++ sha1sum javac java zip python3 arm-none-eabi-as picasso; do
    require_command "$tool"
done

# android.mk runs check_overlays.py using system python3, NOT build/venv.
# Validate both the bindings and libclang's shared library before a long build.
if command -v python3 >/dev/null 2>&1; then
    if ! python3 - >/dev/null 2>&1 <<'PY'
from clang import cindex
cindex.Index.create()
PY
    then
        echo 'BLOCKED: system python3 cannot load libclang (Ubuntu: sudo apt install python3-clang).' >&2
        missing=1
    fi
fi

SDK="${ANDROID_HOME:-$HOME/Android/Sdk}"
if [[ ! -d "$SDK" ]]; then
    echo "BLOCKED: Android SDK not found at $SDK (set ANDROID_HOME)." >&2
    missing=1
else
    BT="$(find "$SDK/build-tools" -mindepth 1 -maxdepth 1 -type d -print 2>/dev/null | sort -V | tail -n 1 || true)"
    API="$(find "$SDK/platforms" -mindepth 2 -maxdepth 2 -name android.jar -type f -print 2>/dev/null | sort -V | tail -n 1 || true)"
    NDK_BIN="${NDK_BIN:-$(find "$SDK/ndk" -path '*/toolchains/llvm/prebuilt/linux-x86_64/bin' -type d -print 2>/dev/null | sort -V | tail -n 1 || true)}"
    if [[ -z "$BT" || -z "$API" || -z "$NDK_BIN" ]]; then
        echo 'BLOCKED: Android build-tools, platform or Linux NDK missing.' >&2
        missing=1
    else
        for tool in aapt2 d8 zipalign apksigner; do require_executable "$BT/$tool"; done
        require_executable "$NDK_BIN/llvm-nm"
        require_executable "$NDK_BIN/aarch64-linux-android33-clang"
    fi
fi

PY="${PYTHON:-$REPO/build/venv/bin/python}"
require_executable "$PY"
if [[ "${VOXEL_LOCAL:-0}" == 1 ]]; then
    if [[ -x "$PY" ]] && ! "$PY" -c 'import PIL' >/dev/null 2>&1; then
        echo 'BLOCKED: VOXEL_LOCAL=1 needs Pillow installed in build/venv.' >&2
        missing=1
    fi
else
    require_command podman
fi
if [[ ! -f "$HOME/.android/debug.keystore" ]]; then
    echo 'BLOCKED: Android debug.keystore missing (create a local debug key).' >&2
    missing=1
fi
if [[ -n "${KEYSTORE:-}" ]]; then
    echo 'BLOCKED: KEYSTORE is set; only the local debug key is allowed.' >&2
    missing=1
fi
if (( missing )); then
    echo 'RESULT: BLOCKED; no APK built and no app installed.' >&2
    exit 1
fi

echo "PASS: preflight; source revision $(git -C "$REPO" rev-parse --short HEAD)."
if (( ! BUILD )); then
    echo 'NEXT: add --build to build the development APK without installing it.'
    exit 0
fi
echo 'BUILD: debug APK only. Installation disabled.'
exec env -u RELEASE -u PACKAGE -u KEYSTORE -u KEYSTORE_PASS LANGS=fr \
    bash "$REPO/android_port/tools/build.sh" --roms "$ROMS" --no-install
