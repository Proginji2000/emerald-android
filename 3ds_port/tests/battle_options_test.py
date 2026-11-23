"""Guard the battle speed option's registration and reuse of the engine API.

This is a structural source test only: it does not measure Android frame rates.
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
options = (ROOT / "src/3ds_bottom_options.inc").read_text(encoding="utf-8")
extras = (ROOT / "src/3ds_extras.c").read_text(encoding="utf-8")
settings = (ROOT / "src/3ds_settings.c").read_text(encoding="utf-8")
android_input = (ROOT.parent / "android_port/src/android_input.c").read_text(encoding="utf-8")


def section(source, start, end):
    return source.split(start, 1)[1].split(end, 1)[0]


def main():
    scene = section(options, "static const OptRowDef sRowsScene[]", "static const OptRowDef sRowsRules[]")
    assert 'EXTRA_ROW("battle_speed")' in scene
    assert scene.count("EXTRA_ROW(") == 1
    assert 'GROUP(CTR_TEXT("SCENE"' in options

    assert '"battle_speed", 0, 0, NULL, NULL, BattleSpeedStep, BattleSpeedText' in extras
    assert '"VITESSE COMBAT"' in extras
    assert '"ÉVOL. SANS ÉCHANGE"' in extras

    step = section(extras, "static void BattleSpeedStep(int direction)", "static const u8 *BattleSpeedText")
    assert 'CtrSettings_GetInt("battle_speed", 0)' in step
    assert 'CtrSettings_StepBattleSpeed(-1, false)' in step
    assert 'CtrSettings_StepBattleSpeed(1, false)' in step
    assert 'CtrSettings_SetInt("battle_speed", 0)' in step
    assert 'CtrSettings_SetInt("battle_speed", 2)' in step
    assert 'CtrSettings_SetInt("battle_speed", 8)' in step
    assert "static const u8 following[] = {CHAR_A, CHAR_U, CHAR_T, CHAR_O, EOS}" in extras

    # Persistent settings are outside the GBA save, and the UI uses the engine.
    assert 'CtrSettings_GetInt("battle_speed", 0)' in settings
    assert 'void CtrSettings_StepBattleSpeed(int direction, bool wrap)' in settings
    assert '"speed", 0, 0, NULL, NULL, SpeedStep, SpeedText' in extras
    # On the Thor the physical ZL/ZR controls follow the active scene.
    # L/R still take the existing game_bridge shortcut in battle.
    keys = section(android_input, "void CtrInput_Scan(void)", "const CtrInput *CtrInput_Get(void)")
    assert "CtrPlatform_BattleSpeedKeys()" in keys
    assert "if (down & HOST_BTN_ZR)" in keys
    assert "if (down & HOST_BTN_ZL)" in keys
    assert "CtrPlatform_StepBattleSpeed(1, false);" in keys
    assert "CtrPlatform_StepBattleSpeed(-1, false);" in keys
    assert "CtrSettings_StepSpeed(1, false);" in keys
    assert "CtrSettings_StepSpeed(-1, false);" in keys
    assert keys.index("if (battle)") < keys.index("CtrPlatform_StepBattleSpeed(1, false);")
    print("PASS battle options: AUTO, engine, French labels and Android ZL/ZR routing")


if __name__ == "__main__":
    main()
