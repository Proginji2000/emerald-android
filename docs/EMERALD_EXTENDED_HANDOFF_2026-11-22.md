# Passation technique — Emerald Android / Emerald Extended

**Datation :** 2026-11-22, 18:26 (Europe/Paris). Cette fiche est un instantané ; recontrôler les états GitHub et CI au début de chaque reprise.

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
