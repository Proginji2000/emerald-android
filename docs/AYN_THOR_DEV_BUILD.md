# AYN Thor — compiler un APK français de développement

**Périmètre :** version française personnelle, AYN Thor, sans remplacement de
l'application stable `com.cer0.emerald`.

## Statut et restrictions

- La CI du commit d'intégration `a075c2c5` a réussi les jobs
  `host-tests`, `build-3ds` et `audit-and-python`
  (run https://github.com/Proginji2000/emerald-android/actions/runs/45051243446).
  **Cela ne constitue pas un build Android ni un test de la Thor.**
- L'APK de test attendu : `build/android-dev/emerald-android-dev.apk`,
  package `com.cer0.emerald.dev`.
- Ne pas utiliser `--release`, qui prépare le package officiel.
- Ne pas publier de ROM, sauvegarde, recette locale, APK de test dérivé de la ROM
  ni logs contenant des chemins ou données privés sur GitHub.

## Prérequis (ordinateur local Linux / WSL2)

Le dépôt doit être sur la branche `tooling/android-fr-preflight-20261122`
(empilée sur `integration/ayn-thor-preview-20261122`).
Les prérequis découlent de `android_port/tools/build.sh` et
`android_port/build_apk.sh` :

- ROM française Pokémon Émeraude BPEF personnelle et propre, SHA-1
  `ca666651374d89ca439007bed54d839eb7bd14d0`, dans un répertoire local.
- SDK Android avec build-tools, android.jar, NDK Linux, JDK et clé debug.
- devkitPro (devkitARM, libctru, citro2d, citro3d, 3dstools, `picasso`).
- Compilateurs hôte gcc/g++, git, make et `build/venv/bin/python`.
- Podman pour `voxel_precompile.py`, ou `VOXEL_LOCAL=1` avec la version
  Python/Pillow épinglée dans `upstream.lock`.
- Réseau pour le bootstrap de `pret/pokeemerald` épinglé et ses dépendances.

L'installation des prérequis n'est pas automatique. Le précontrôle indique les
éléments absents avant d'exécuter le compilateur. Sous Windows, utiliser WSL2
avec **les outils Linux**, pas un mélange NDK Windows/compilateur WSL.

## Procédure

À la racine du clone local :

```bash
git checkout tooling/android-fr-preflight-20261122
bash android_port/tools/preflight_fr.sh --roms "/chemin/local/roms"
```

**STOP** si le résultat est BLOCKED. Corriger uniquement le prérequis indiqué ;
ne pas contourner le hash de la ROM ou forcer la génération.

Quand le précontrôle est PASS :

```bash
bash android_port/tools/preflight_fr.sh --roms "/chemin/local/roms" --build
```

Le programme utilise le constructeur officiel avec `LANGS=fr` et
`--no-install`. Le script de build conserve les journaux de langue dans
`build/android-dev/logs/fr.log`. La première génération de relief/recettes
et le bootstrap peuvent nécessiter des composants déjà préparés ; les échecs
doivent être analysés comme tels, sans annoncer une compilation réussie.

## Qualification avant toute installation

Sur la machine de compilation, inspecter le fichier réel et l'identité de l'APK :

```bash
APK=build/android-dev/emerald-android-dev.apk
test -f "$APK"
"$ANDROID_HOME"/build-tools/$(ls "$ANDROID_HOME/build-tools" | sort -V | tail -1)/apksigner verify --verbose "$APK"
"$ANDROID_HOME"/build-tools/$(ls "$ANDROID_HOME/build-tools" | sort -V | tail -1)/aapt2 dump packagename "$APK"
sha256sum "$APK"
```

La sortie du manifeste **doit** être `com.cer0.emerald.dev`. Si une commande
échoue, ou si le package est `com.cer0.emerald`, **STOP : ne pas installer**.

L'installation (distincte du build) et l'import de la ROM de test ne doivent
commencer qu'après vérification de l'APK. La sauvegarde officielle reste dans
son espace Android d'origine. Si une sauvegarde est importée dans le profil dev,
respecter le propriétaire UID de l'application (incident historique `EACCES`)
et conserver les fichiers `.sav`, `.clock` et `.clock.bak` intacts dans une
copie hors appareil. Tester ensuite carte, mode Vol, accélération combat,
commandes, cycle jour/nuit et sauvegarde/reprise sur AYN Thor.

## Vérification CI de cet outil

`bash -n`, `--help` et rejet déterministe d'un faux fichier `.gba`
avec erreur de hash. **Ce test n'utilise aucune ROM réelle et ne compile
aucun APK.**
