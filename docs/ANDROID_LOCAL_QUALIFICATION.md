# Qualification locale et déploiement Emerald Extended

**État au 24/11/2026 :** plan préparé ; liaison VM → WSL → AYN Thor non qualifiée. Référence EE-002 / issue #9. Ne pas confondre accès GitHub, CI 3DS, compilation Android et essais matériels.

## Architecture et limites
- La stack IA demande des travaux à un exécuteur local dédié sur WSL2 (poste de compilation existant). WSL conserve ROM française, SDK/NDK et clé debug ; ne pas les transférer au runner public.
- Le PC de compilation pilote une seule Thor explicitement identifiée via ADB USB ou débogage sans fil Android autorisé par son propriétaire. Pas d'ADB exposé sur Internet ; pas de port 5555 ouvert globalement.
- Préférer une liaison SSH par clé, restreinte aux opérations Emerald et au réseau privé ; vérifier routage WSL/NAT et pare-feu avant choix du transport. Alternative : exécuteur local qui récupère les missions autorisées. Ne pas déployer de runner auto-hébergé public exécutant des PR non fiables.
- L'application officielle com.cer0.emerald et toutes ses données sont hors périmètre. Seul com.cer0.emerald.dev peut être piloté. Les scénarios avec sauvegarde exigent une fixture de test et un mécanisme de restauration démontré.
- Cette préparation ne nécessite aucune modification de la VM de production de l'orchestrateur. Intégrer la liaison seulement après qualification et autorisation de la stack.

## Étapes de qualification

| Phase | Critères |
| --- | --- |
| A — Inventaire | WSL, checkout, outils, SDK, service/écoute SSH, ADB et device identifié ; commandes de lecture uniquement |
| B — Transport | Connexion authentifiée depuis la future cible autorisée, droits minimaux, test de commande non destructive ; pas d'accès à la totalité du PC |
| C — Build | Commit exact et CI qualifiée, preflight_fr.sh --build avec VOXEL_LOCAL=1 et ROM locale ; vérifier package Dev et signature, archiver empreinte APK et log local |
| D — Déploiement | Détecter et valider modèle/série ADB ; vérifier sauvegardes Dev et APK précédent, espace et signature ; installer uniquement le package Dev en conservant ses données, vérifier démarrage |
| E — Tests | Smoke test, commandes, capture écran haut/bas, logs horodatés ; scénarios reproductibles ; vérifier assertions et absence de crash |
| F — Rollback | Retour à un APK compatible signé par la même clé et restauration qualifiée des données Dev ; ne jamais désinstaller/effacer les données en cas d'échec |
| G — Orchestrateur | Mission structurée avec commit, mode build/test/déploiement, numéro de série, résultat et preuves ; exécution sérialisée et délais bornés |

## Briques vérifiées dans la branche PR #7
- android_port/tools/preflight_fr.sh : build FR debug, sans installation.
- android_port/tools/build.sh : constructeur existant, installation ADB optionnelle. Conserver --no-install pour contrôler explicitement le résultat avant déploiement.
- android_port/tools/capture.sh : déclenchement et récupération des deux écrans ; adapter sélection ADB, fraîcheur des fichiers et validation des dimensions.
- android_port/tools/newgame.sh : injection de touches et lecture des logs ; il efface actuellement le journal logcat et lance une nouvelle partie. **Ne pas exécuter sans fixture et protections.** Ne pas assimiler son message final à un test réussi.
- android_port/src/android_log.c : tag logcat Emerald, et port.log si debug.txt existe. Collecter les logs de la session Dev, sans effacer le journal global.
- 3ds_port/src/3ds_scenario.c : mécanisme de record/play/queue, sauvegarde mémoire en lecture playback et digests. Le build Android inclut cette source via android_port/android.mk et android_platform.c initialise le scénario. Qualifier réellement sur Thor avant utilisation. Un scénario peut contenir une sauvegarde : conserver localement uniquement.

## Première action — diagnostic local, sans modification de configuration
Sur WSL2 existant, avec Thor allumée et reliée en USB si possible :
```bash
cd "$HOME/emerald-android-dev" || exit 1
printf '\n=== CHECKOUT ===\n'
git branch --show-current
git rev-parse --short HEAD
git status --short
printf '\n=== WSL / SSH ===\n'
uname -r
command -v ssh || true
command -v sshd || true
systemctl is-active ssh 2>/dev/null || true
ss -ltn
printf '\n=== SDK / ADB ===\n'
SDK="${ANDROID_HOME:-$HOME/Android/Sdk}"
if command -v adb >/dev/null 2>&1; then
    adb version
    adb devices -l
elif [[ -x "$SDK/platform-tools/adb" ]]; then
    "$SDK/platform-tools/adb" version
    "$SDK/platform-tools/adb" devices -l
else
    echo 'ADB Linux absent ou non accessible'
fi
```
ADB peut démarrer son daemon local. Ne pas accepter de clé d'une machine inconnue. Si aucun appareil n'est détecté, qualifier ensuite ADB Wi-Fi ou le pont Windows/USB ; aucune hypothèse de routage.

## Conditions STOP
- Identité de console ambiguë, package incorrect, signature différente, build/CI FAIL, sauvegarde non préservée, appareil indisponible, exécution concurrente.
- Le défaut SAVE EE-001 bloque la validation de déploiement automatique avec sauvegarde. Les diagnostics en lecture seule restent autorisés.
- Ne publier ni ROM, sauvegarde, captures contenant données de jeu privées, clé debug, ni APK local. Les rapports publics ne contiennent que résultats et preuves expurgées.
