# Passation technique — Emerald Android / Emerald Extended

**Datation :** 2026-11-22, 18:26 (Europe/Paris). Cette fiche est un instantané ; recontrôler les états GitHub et CI au début de chaque reprise.

## Actualisation — 24 novembre 2026 (état courant, prioritaire sur les instantanés historiques)

**STATUS : PARTIAL.** Le fork possède désormais un APK Android français de développement compilé localement et démarré sur AYN Thor. La sauvegarde reste bloquante. Aucun merge sur `main` (vérifié : `ba8ca267`).

### Références et preuves

| Élément | Référence | État |
| --- | --- | --- |
| Base intégrée | `integration/ayn-thor-preview-20261122`, `a075c2c5` | CI 3DS PASS, run [45051243446](https://github.com/Proginji2000/emerald-android/actions/runs/45051243446) |
| Précontrôle FR | [PR #6](https://github.com/Proginji2000/emerald-android/pull/6), `tooling/android-fr-preflight-20261122`, `0667b39` | CI PR [45263652888](https://github.com/Proginji2000/emerald-android/actions/runs/45263652888) SUCCESS ; run push 45263639208 FAILURE |
| APK FR initial | `0667b39`, package `com.cer0.emerald.dev`, v0.5.0.3 | Compilation locale WSL2 PASS, signature APK v3 et package vérifiés ; installation et chargement ROM PASS sur Thor |
| Correctifs runtime | [PR #7](https://github.com/Proginji2000/emerald-android/pull/7), `fix/thor-runtime-feedback-20261123`, `1d27ad64` | CI push [45269989952](https://github.com/Proginji2000/emerald-android/actions/runs/45269989952) SUCCESS ; CI PR [45270004191](https://github.com/Proginji2000/emerald-android/actions/runs/45270004191) FAILURE sur build-3ds, relance des jobs échoués demandée le 24/11. Cause non établie (logs indisponibles, états d'étapes incohérents). |
| Code runtime avant ajout du rapport QA | `f6373bbc` | CI push 45269488061 et PR 45269556928 SUCCESS |

Les correctifs ASan des tests hôte utilisent des exécutables non-PIE sous Linux, sans supprimer ASan/UBSan. Le précontrôle de la PR #6 détecte désormais le besoin de `python3-clang` du Python système. Le build Android local initial a abouti le 23/11 avec ROM FR validée. **Pas de nouvel APK compilé depuis la PR #7.**

### État fonctionnel et priorités

| Chantier | Observation / modification | Qualification |
| --- | --- | --- |
| P0 — APK FR / démarrage / commandes | Nouvelle partie jouable | PASS initial, pas validation exhaustive des deux écrans |
| P0 — SAVE / import | Écran bleu avec texte illisible après tentative d'import officiel ; erreur de sauvegarde en nouvelle partie | FAIL ; permissions/format à diagnostiquer, aucun correctif prouvé |
| P1 — vitesse | Vitesse générale et combat ×4 fonctionnent indépendamment ; gâchettes inefficaces pour régler le combat sur APK initial | PR #7 : ZL/ZR routés vers combat en scène active, sinon vitesse générale ; L/R existants conservés ; test Thor à faire |
| P1 — carte | Aucun changement apparent avec mode progressif initial | PR #7 : marqueurs visités uniquement et compteur de villes, carte classique et Vol conservés ; test Thor à faire |
| P1 — jour/nuit | Fonctionnel sur version antérieure selon utilisateur | Non retesté sur APK courant |
| P1 — évolutions sans échange | Libellé corrigé dans PR #4, seuil 40 existant | Test en jeu restant |
| P2 — PokéNav | Rencontres et taux existants, statut capturé et index objets/cadeaux/échanges à étendre | À développer |
| P3 — saisons | Étude de réutilisation et compatibilité | À étudier |
| P4 — Acte II | Campagne narrative post-Ligue, quêtes principales et secondaires, PNJ, dialogues, exploration, huit nouveaux badges et Ligue renforcée | À concevoir |

### Nouvelle exigence P4 — 24/11/2026

L'utilisateur demande explicitement de prolonger le **scénario**, et non de limiter le postgame aux combats. Concevoir un Acte II cohérent avec Hoenn : intrigue principale, chapitres, quêtes hors combat, nouveaux événements/PNJ, dialogues conditionnels, exploration, récompenses, puis résolution narrative. Les huit badges sont des jalons, pas le seul objectif. Les pistes Aqua/Magma, anomalies climatiques, ruines et légendaires restent des propositions à valider. Réutiliser les scripts et systèmes de progression existants après audit. Premier prototype : chapitre jouable après la Ligue, objectif hors combat, récompense unique, sauvegarde/reprise. Voir section P4 de la roadmap. Aucun contenu narratif nouveau implémenté à ce jour.

### Reprise immédiate

1. Lire [le rapport QA du 23/11](https://github.com/Proginji2000/emerald-android/blob/fix/thor-runtime-feedback-20261123/docs/AYN_THOR_QA_2026-11-23.md). Recontrôler le run PR #7 relancé, sans supposer sa réussite.
2. Priorité absolue : diagnostic de sauvegarde Dev. Dans le dossier **Dev uniquement** `Android/data/com.cer0.emerald.dev/files/fr/sdmc/3ds/emerald3ds/`, conserver copie des `.sav`, `.sav.not-emerald*` et des fichiers horloge. Créer `debug.txt`, reproduire l'échec, lire les lignes pertinentes de `port.log`. Ne pas modifier les droits ou déplacer les fichiers originaux sans diagnostic. Un ancien incident EACCES/UID est une piste, pas une preuve de la cause actuelle.
3. Qualifier le prochain APK local issu de PR #7 : récupérer la branche `fix/thor-runtime-feedback-20261123`, utiliser `VOXEL_LOCAL=1 bash android_port/tools/preflight_fr.sh --roms "$HOME/gba_roms" --build`. Contrôler signature et package `com.cer0.emerald.dev` avant installation. Aucun APK, ROM ou save privé ne doit être publié.
4. Retester carte classique/progressive, compteur, gâchettes ZL/ZR et indépendance des vitesses, sauvegarde/reprise, import sans perte, horloge et jour/nuit.
5. Après stabilité, reprendre PokéNav, saisons, postgame. Réutiliser les implémentations existantes seulement après audit de licence et de compatibilité.

Toutes les PR restent en brouillon ; `main` et l'application officielle doivent rester intacts. Les sections datées ci-dessous sont conservées comme historique, et non comme état courant.

## 1. Dépôts, branches, règles

- **Fork :** https://github.com/Proginji2000/emerald-android
- **Upstream :** https://github.com/Cer0-D/emerald-android
- **Base actuelle upstream/main et fork/main :** `ba8ca2671255d5b96c13d2b817e1721517299f90` (v0.5.0.3).
- **PR #1 — carte progressive :** https://github.com/Proginji2000/emerald-android/pull/1
- **Branche fonctionnelle :** `feat/visited-city-markers`, SHA connue `588009794fe0d6c4a763f29ea4120b6d247742c8` ; PR en brouillon, NON FUSIONNÉE.
- **Branche documentaire :** `docs/emerald-extended-roadmap-20261122`, séparée de la PR #1 et de `main`.
- **Spécification intégrale :** `docs/EMERALD_EXTENDED_ROADMAP.md`.
- Ne pas pousser sur `main` sans contrôle/autorisation ; conserver la synchronisation upstream.
- Les fichiers de sauvegarde et données ROM restent hors dépôt, sans pièce jointe aux tickets publics.

## 2. Situation technique vérifiée

### PR #1 : carte progressive

- Le code a été modifié dans `3ds_port/src/3ds_bottom_ui.c` et `3ds_port/src/3ds_bottom_field.inc` pour appliquer les flags visités aux icônes de la carte permanente et restaurer le rendu dans la voie de redessin partiel.
- Des tests ont été ajoutés à `3ds_port/tests/bottom_map_test.py`.
- Plusieurs corrections de fixtures host/voxel ont été ajoutées : `gLinkPlayerObjectEvents`, `gFieldCamera`, `gSprites`, `sFrameReserveMs`.
- **Host tests : PASS** sur le dernier SHA vérifié.
- **CI sur le SHA `58800979` :** run push `45047313756` terminé FAILURE ; l'étape `verify-pokedex-capture` a rencontré `AddressSanitizer:DEADLYSIGNAL` / `SIGSEGV` dans un binaire de test. Le run PR `45047318776` était encore en cours à la dernière consultation. Ne pas présenter cette étape comme PASS.
- **Audit publication : FAIL** sur 5 images de lanceur sans provenance documentée et `android_port/third_party/dlmalloc` sans licence acceptée, constat antérieur non attribué à l'interface. Ne pas désactiver l'audit pour obtenir un faux PASS.
- Aucune compilation Android APK nouvelle ni test visuel AYN Thor dans cette branche ne sont confirmés.
- La carte progressive doit disposer d'une option CLASSIQUE/PROGRESSIVE avant le déploiement public.

### Appareil et sauvegarde

- **Appareil :** AYN Thor, Android, double écran.
- **Application testée :** Emerald Android français 0.5.0.3 ; APK actuellement fonctionnel à conserver intact.
- **Package :** `com.cer0.emerald`.
- **Sauvegarde :** `/storage/emulated/0/Android/data/com.cer0.emerald/files/fr/sdmc/3ds/emerald3ds/emerald3ds.sav` ; 131 072 octets.
- **Incident passé :** après import externe, chargement fonctionnel mais erreur « backup memory damaged » lors de l'enregistrement. Logcat : `save write failed: offset=94208 size=4096 errno=13` (EACCES).
- **Cause démontrée :** UID du fichier différent de l'UID `10138` de l'application. Résolution avec création du fichier par l'app (UID `10138`, mode `660`), puis copie des octets en place, contrôle SHA-256 et vérification en jeu confirmée par l'utilisateur.
- Éviter `adb push` direct sur le fichier final (risque de recréation sous UID shell). Préserver les sauvegardes PC et le triplet `.sav`/`.clock`/`.clock.bak`.
- Un pack d'événements/Pokémon a été préparé dans l'ancienne conversation. **Légalité PKHeX des Pokémon générés non validée** ; ne pas déclarer ces PK3 légaux sans test.

## 3. Dernière discussion — conclusions confirmées par le code

**Question de l'utilisateur :** ajout de rencontres et taux par route sur le deuxième écran, statut vu/capturé, objets uniques/respawn, cadeaux/échanges en ville, saisons, cycle jour-nuit ; accélération des combats ; sens du réglage « ÉVOL. NIV. 40 » ; préférence réutilisation de code existant.

- `patches/pokeemerald/0012-trade-evolutions.patch` : option `trade_evo` existe. Au niveau **40**, les évolutions par échange sont possibles ; avec objet tenu si nécessaire, celui-ci est consommé lors de l'évolution. Elle est optionnelle, à améliorer surtout par le libellé français.
- `docs/DAY_NIGHT.md` : DAY/NIGHT OFF/AUTO (OFF par défaut) ; CLOCK SPEED ×1,6,12,24,60,120 (×1 par défaut) ; WILD POKEMON ORIGINAL/TIMED (ORIGINAL par défaut) ; SHOW CLOCK OFF/ON ; synchronisation. Chemin des options dans le portage : **Options → Monde → Horloge**.
- Phase des rencontres documentée : matin 04:00–09:59 ; jour 10:00–19:59 ; nuit 20:00–03:59. L'éclairage crépusculaire est un autre mécanisme, non identique à ces tranches. Route 102 possède déjà des substitutions horaires.
- `docs/field-interface.md` et `3ds_port/src/3ds_bottom_ui.c` : AREA WILD LIST existe ; liste méthodes herbe, Surf, Éclate-Roc, cannes, taux, niveaux ; `???` pour espèces jamais vues. Taux = poids des slots, **pas** probabilité d'une rencontre au prochain pas. Le statut « capturé » par zone, les objets et échanges ne sont pas déjà intégrés dans cet écran.
- `3ds_port/tests/battle_speed_test.c` : moteur de vitesse spécifique de combat déjà présent ; suit la vitesse générale tant que non modifiée ; pas de ×1,5,2,3,4 ; persiste comme `battle_speed`. L'interface de choix visible et la performance physique sur AYN sont à développer/mesurer. Les raccourcis R1/L1 et R2/L2 décrits précédemment restent à tester sur le mapping réel de l'appareil.
- Les saisons complètes ne sont pas établies comme existantes dans ce portage. Ne pas confondre cycle jour/nuit, calendrier, météo et saison.

## 4. Références à comparer sans réimplémenter

- PokeDaisy smart fast-forward : https://pokedaisy.com/docs/fast-forward/
- PokeDaisy projet : https://github.com/DonovanSwinthrop/thor-companion
- Portage dual-screen alternatif : https://github.com/Goldoire/pokeemerald-dualscreen
- Base d'expansion : https://github.com/rh-hideout/pokeemerald-expansion
- Emerald Crest (saisons) : https://thatsimpledev.itch.io/emerald-crest
- Emerald Rogue (autre gameplay mais idées techniques) : https://github.com/Pokabbie/pokeemerald-rogue
- Ne jamais présumer la licence/code réutilisable ; vérifier chaque composant et la version `pokeemerald` épinglée avant intégration.

## 5. Prochaine séquence souhaitée

1. Relire cette passation et la feuille de route, puis relire la PR #1 et les états CI **actuels**.
2. Établir la cause du `SIGSEGV` ASan `pokedex_capture` ou démontrer qu'il est extérieur à la PR sans désactiver les tests.
3. Corriger et vérifier la chaîne de build/test Android avant d'annoncer un APK installable.
4. Sur branche distincte, proposer un réglage explicite **VITESSE COMBAT**, sans dupliquer `battle_speed`, et améliorer le libellé FR de `trade_evo`.
5. Spécifier le PokéNav dynamique à partir des données déjà disponibles : les objets doivent être reliés aux états de scénario et aux règles de réapparition, pas à des faux statuts persistants.
6. Étudier les saisons et le postgame séparément, avec audits de compatibilité et licences.
7. Conserver les PR en brouillon tant que les tests nécessaires sont incomplets. Remonter un état PASS/PARTIAL/FAIL/BLOCKED avec preuves réelles.

**Exécution :** privilégier modifications autonomes groupées, commits ciblés, comparaison GitHub, tests CI ; ne demander à l'utilisateur que les contrôles réellement nécessaires sur AYN Thor ou la fourniture locale de ses propres données de jeu. Ne pas attribuer des tests non exécutés au matériel.

## 6. Reprise GitHub exécutée le 22 novembre 2026

- `main` du fork et upstream identiques (`ba8ca267`), non modifiés.
- PR #1 : `58800979`, `host-tests` PASS, ASan `SIGSEGV` dans
  `verify-pokedex-capture` au run push `45047313756`, cause non démontrée.
- **PR #3 — audit :** https://github.com/Proginji2000/emerald-android/pull/3 ;
  commit `ca7d966d` ; 5 dérivés d'icônes documentés dans l'allowlist,
  licence/source de `dlmalloc` documentées. Comparaison texte complète
  identique (221 525 caractères) avec Boost.Container 1.92.0 `dlmalloc_2_8_6.c`.
  `audit-and-python` PASS sur run `45050456744` ; `host-tests` FAIL pour la fixture de base.
- **PR #4 — vitesse combat et libellé FR :** https://github.com/Proginji2000/emerald-android/pull/4 ;
  commit `ee834a5e` ; `VITESSE COMBAT` dans Combat → Scène, valeurs AUTO/1/1,5/2/3/4×,
  réemploi du moteur `CtrSettings_StepBattleSpeed`. Le nouveau pas CI
  `Battle speed option registration` est PASS sur run `45050810065`.
  Le job `host-tests` reste FAIL à cause de la fixture de base.
- **PR #5 — choix CLASSIQUE/PROGRESSIVE :** https://github.com/Proginji2000/emerald-android/pull/5 ;
  commit `4e1fc36d`, branchée sur PR #1 (stacked, base `feat/visited-city-markers`).
  `host-tests` PASS sur run `45050969611`; les autres jobs doivent être recontrôlés.
  La carte classique est la valeur par défaut ; le mode Vol reste inchangé.
  Aucun changement du format de sauvegarde.
- Les audits des PR #4/#5 restent FAIL **tant que la PR #3 n'est pas intégrée**.
  Ne pas changer les contrôles pour dissimuler cet état.
- Les builds 3DS de ces PR étaient encore en cours au dernier contrôle ; aucun APK Android
  du fork n'a été généré, installé ou testé sur AYN Thor.

### Suite immédiate

1. Recontrôler les dernières CI : tous les jobs, les causes exactes et les runs après merge/rebase.
2. Diagnostiquer l'ASan `pokedex_capture` avec des preuves reproductibles, sans désactiver les sanitizers.
3. Intégrer de façon contrôlée la correction d'audit et les corrections de fixture/test ;
   requalifier la PR #4 et la PR #5 sur les nouvelles bases.
4. Préparer la compilation **développement uniquement** :
   `LANGS=fr bash android_port/tools/build.sh --roms "/chemin/vers/roms" --no-install`.
   SHA-1 ROM FR attendu : `ca666651374d89ca439007bed54d839eb7bd14d0`.
   APK dev : `build/android-dev/emerald-android-dev.apk`, package `com.cer0.emerald.dev`.
   Ne pas employer `--release` ou `adb install -r` sur le package officiel.
5. Effectuer sur AYN Thor les essais carte classique/progressive, mode Vol, vitesse réelle
   en combat, commandes, cycle jour/nuit, et sauvegarde/relance. Aucun essai non exécuté
   ne peut être déclaré PASS.
6. Passer ensuite au PokéNav dynamique par zone, avant saisons et postgame.

**Interdits conservés :** aucune ROM, sauvegarde ou donnée personnelle dans GitHub ;
aucune modification de `main` sans qualification ; aucune désactivation de l'audit ;
aucun écrasement de l'application stable.

## 7. Branche intégrée de prévisualisation (sans merge sur main)

- **Branche :** `integration/ayn-thor-preview-20261122`
- **Commit :** `a075c2c51a6f2f1241baccb94de46ad31bb43779`
- **Base :** `feat/map-display-mode-20261122` au commit `4e1fc36d`.
- **Contenu :** PR #1 (marqueurs carte), PR #5 (mode CLASSIQUE/PROGRESSIVE),
  PR #4 (VITESSE COMBAT et libellé FR), PR #3 (attributions et licence).
  Les deux fichiers d'options ont été fusionnés sans écraser la ligne `map_progressive`.
- **CI push :** https://github.com/Proginji2000/emerald-android/actions/runs/45051243446 .
  **Résultat contrôlé : `host-tests` PASS, `build-3ds` PASS et `audit-and-python` PASS.** Le run `45051243446` est terminé SUCCESS. Aucun APK Android compilé.
- **Usage :** seule source cohérente pour tenter une compilation de développement
  regroupant les fonctions prioritaires ; **aucun APK compilé** lors de cette reprise.
- **Politique :** branche provisoire non destinée à un merge automatique.
  Les PR indépendantes restent les unités de revue. Aucun changement de `main`.

Lancer uniquement le build de développement `LANGS=fr bash
android_port/tools/build.sh --roms "/chemin/vers/roms" --no-install`
après préparation locale de la ROM FR et des toolchains. L'installation du
paquet `com.cer0.emerald.dev` et l'injection de ROM restent des opérations
distinctes, avec vérification des permissions et du jeu sur AYN Thor.

## 8. Passage de la CI au build Android français (22/11/2026, soirée)

**Premier point de qualification :**
La branche combinée `integration/ayn-thor-preview-20261122` au commit
`a075c2c5` a **trois jobs PASS** sur
https://github.com/Proginji2000/emerald-android/actions/runs/45051243446 :
`host-tests`, `build-3ds` et `audit-and-python`.
L'artifact `emerald3ds-engine` existe sur ce run ; **ce n'est pas un APK Android**.
L'ancien run PR #1 sous ASan demeure un échec historique ; il ne faut pas
l'effacer ni déduire un diagnostic C absent de ses logs.

**PR #6 — précontrôle Android :**
https://github.com/Proginji2000/emerald-android/pull/6,
branche `tooling/android-fr-preflight-20261122`, commit `22d31c99`,
empilée sur la branche d'intégration. Elle contient :

- `android_port/tools/preflight_fr.sh` : lecture seule par défaut ;
  vérification SHA-1 de la ROM française et prérequis Linux/WSL2 SDK,
  NDK, devkitPro, Python, Podman et signature de debug.
- Option `--build` : constructeur existant `LANGS=fr`,
  `--no-install` ; variables `RELEASE`, `PACKAGE`,
  `KEYSTORE` neutralisées.
- `docs/AYN_THOR_DEV_BUILD.md` : procédure et critères STOP.
- Test CI sur un fichier `.gba` synthétique invalide, sans ROM vraie.
  **La CI de la PR #6 doit être relue avant de marquer ces tests PASS.**

**Blocage résiduel :** la compilation de l'APK dépend d'une ROM
française personnelle propre et de l'outillage Android sur une machine
locale. Ce contexte n'est pas accessible via le connecteur GitHub.
Aucune ROM ni sauvegarde n'a été transférée. Aucun APK du fork n'a été
compilé/chargé sur l'AYN Thor dans cette reprise.

**Action suivante :** sur le poste local Linux/WSL2, récupérer la branche
`tooling/android-fr-preflight-20261122`, puis exécuter
`bash android_port/tools/preflight_fr.sh --roms "/chemin/local/roms"`.
Après PASS et contrôle des dépendances :
`bash android_port/tools/preflight_fr.sh --roms "/chemin/local/roms" --build`.
Lire les logs réels avant d'envisager l'installation d'un package
`com.cer0.emerald.dev`. Le package stable `com.cer0.emerald` et ses
fichiers restent intacts.
