# Emerald Extended — feuille de route et critères d'acceptation

**État :** document de cadrage, pas une fonctionnalité installée.  
**Date :** 2026-11-22. **Plateforme cible :** Emerald Android de Cer0-D, version française, AYN Thor double écran.  
**Source :** fork `Proginji2000/emerald-android`, upstream `Cer0-D/emerald-android`, `main` au commit `ba8ca2671255d5b96c13d2b817e1721517299f90`.  
**Principe :** expérience Pokémon Émeraude originale préservée ; modifications optionnelles autant que possible.

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
| P1-D — voxel 3D | PNJ sur chaises, plants de baies surélevés ; registre et qualification du rendu | À diagnostiquer |
| P2 — PokéNav | Rencontres et taux existants, statut capturé et index objets/cadeaux/échanges à étendre | À développer |
| P3 — saisons | Étude de réutilisation et compatibilité | À étudier |
| P4 — Acte II | Deuxième campagne scénarisée, quêtes, nouveaux événements, huit badges supplémentaires et Ligue renforcée | À concevoir |

### Organisation opérationnelle et maintenance upstream — 24/11/2026

Le [backlog opérationnel](https://github.com/Proginji2000/emerald-android/blob/main/docs/EMERALD_EXTENDED_BACKLOG.md) centralise 16 tickets préparés EE-001 à EE-016, priorités, dépendances et critères d'acceptation. Les Issues GitHub sont désormais activées ; 16 tickets distincts ouverts, numéros réels et labels référencés dans le backlog. Le doublon #10 est fermé au profit de #9. Voir [Issues](https://github.com/Proginji2000/emerald-android/issues).

La [politique de synchronisation upstream](https://github.com/Proginji2000/emerald-android/blob/main/docs/UPSTREAM_SYNC.md) formalise le suivi conjoint de Cer0-D/emerald-android (parent direct, main/releases) et ZallaxDev/emerald-3ds (main/releases ; dev/integration en veille). Privilégier les mises à jour Android déjà portées, examiner les backports 3DS individuellement, intégrer sur branche dédiée et qualifier sans écraser les modifications locales ni la sauvegarde. Les SHA observés et les références de release sont consignés dans ce document. Ne pas confondre veille avec synchronisation réalisée.

Les derniers changements de main sont documentaires (README, backlog et politique upstream), sans merge du moteur. Les PR #6/#7 restent des branches de développement.

### Reprise immédiate

1. Lire [le rapport QA du 23/11](https://github.com/Proginji2000/emerald-android/blob/fix/thor-runtime-feedback-20261123/docs/AYN_THOR_QA_2026-11-23.md). Recontrôler le run PR #7 relancé, sans supposer sa réussite.
2. Priorité absolue : diagnostic de sauvegarde Dev. Dans le dossier **Dev uniquement** `Android/data/com.cer0.emerald.dev/files/fr/sdmc/3ds/emerald3ds/`, conserver copie des `.sav`, `.sav.not-emerald*` et des fichiers horloge. Créer `debug.txt`, reproduire l'échec, lire les lignes pertinentes de `port.log`. Ne pas modifier les droits ou déplacer les fichiers originaux sans diagnostic. Un ancien incident EACCES/UID est une piste, pas une preuve de la cause actuelle.
3. Qualifier le prochain APK local issu de PR #7 : récupérer la branche `fix/thor-runtime-feedback-20261123`, utiliser `VOXEL_LOCAL=1 bash android_port/tools/preflight_fr.sh --roms "$HOME/gba_roms" --build`. Contrôler signature et package `com.cer0.emerald.dev` avant installation. Aucun APK, ROM ou save privé ne doit être publié.
4. Retester carte classique/progressive, compteur, gâchettes ZL/ZR et indépendance des vitesses, sauvegarde/reprise, import sans perte, horloge et jour/nuit.
5. Après stabilité, reprendre PokéNav, saisons, postgame. Réutiliser les implémentations existantes seulement après audit de licence et de compatibilité.

Toutes les PR restent en brouillon ; `main` et l'application officielle doivent rester intacts. Les sections datées ci-dessous sont conservées comme historique, et non comme état courant.

## 1. Exigences transversales

1. Auditer les fonctions déjà présentes dans le portage avant tout nouveau développement.
2. Rechercher des implémentations existantes dans d'autres ports et ROM hacks, sans copier de code ni d'assets avant revue de licence, provenance, architecture et version de `pokeemerald`.
3. Séparer **observation**, **fonction confirmée par le code**, **test réussi** et **nouvelle proposition**.
4. Conserver `main` synchronisable avec `upstream` ; travailler en branches et PR isolées.
5. Ne pas modifier le format des sauvegardes pour une fonction d'interface si les flags et les données du jeu permettent de l'éviter.
6. Conserver un rollback : copie des `.sav` et fichiers auxiliaires d'horloge `.clock`/`.clock.bak`, APK officiel intact, APK de développement séparé.
7. Aucun fichier ROM, asset de jeu ou sauvegarde privée dans GitHub. Respecter les licences, attributions et contrôles d'audit existants.
8. Documenter les résultats réels des tests ; ne jamais transformer une compilation ou un test non exécuté en PASS.

## 2. Inventaire vérifié dans le dépôt de référence

| Fonction | État établi par lecture des sources | Action proposée |
| --- | --- | --- |
| Évolutions par échange | **EXISTE** ; `patches/pokeemerald/0012-trade-evolutions.patch`, `CtrExtras_Get("trade_evo")`, seuil 40 ; si objet requis, il doit être tenu et est consommé | Renommer « ÉVOL. NIV. 40 » de manière explicite ; valider en jeu |
| Cycle jour/nuit | **EXISTE**, désactivé par défaut ; `docs/DAY_NIGHT.md` | Tester le rendu Android/voxel sur AYN Thor |
| Horloge | **EXISTE** ; ×1, ×6, ×12, ×24, ×60, ×120 ; affichage et synchronisation séparés | Documenter interactions RTC/baies et sauvegarde auxiliaire |
| Rencontres horaires | **EXISTE**, option ORIGINAL/TIMED ; matin 04:00–09:59, jour 10:00–19:59, nuit 20:00–03:59 ; Route 102 concernée | Vérifier tables activées et source du taux |
| Liste des sauvages par zone | **EXISTE**, optionnelle ; herbes, Surf, Éclate-Roc, cannes ; taux par slot ; non-vus masqués par « ??? » | Étendre avec statut capturé et pagination dynamique |
| Vitesse de combat | **EXISTE** dans `3ds_port/tests/battle_speed_test.c` ; vitesse séparée ×1 à ×4, suit la vitesse générale tant qu'elle n'est pas réglée indépendamment | Exposer un réglage « VITESSE COMBAT » ; vérifier raccourcis physiques et vitesse réelle |
| Carte progressive | **EN DÉVELOPPEMENT** dans PR #1 ; réutilisation des flags de villes visitées | Compiler, tester les icônes, la restauration du cache et le mode classique |
| Quatre saisons | **NON CONFIRMÉES comme fonctionnalité existante** ; module proposé | Audit puis conception optionnelle |
| Suivi objets/cadeaux/échanges | **NON IMPLÉMENTÉ comme inventaire dynamique de zone**, au vu des fonctions consultées | Concevoir index des sources, flags et cycles de réapparition |
| Postgame narratif / Acte II | **PROJET**, non développé | Chapitres, missions hors combat, PNJ, dialogues, exploration, huit badges supplémentaires et Ligue renforcée |

Les éléments marqués « existe » restent à valider sur le matériel cible. Un comportement du portage 3DS ne démontre pas automatiquement un test réussi sur Android.

## 3. Chantier P0 : construire une base fiable

**PR existante :** https://github.com/Proginji2000/emerald-android/pull/1  
**Branche :** `feat/visited-city-markers` ; dernière référence connue le 2026-11-22 : `588009794fe0d6c4a763f29ea4120b6d247742c8`.

- Conserver la PR en brouillon jusqu'à compilation Android, vérification de la carte et tests sur AYN Thor.
- Ne pas confondre `host-tests` PASS et compilation complète 3DS/Android.
- Vérifier que les marqueurs non visités sont sombres, les visités colorés, la position du joueur intacte et le curseur sans artefacts.
- Prévoir un choix de rendu CLASSIQUE/PROGRESSIF ; vérifier l'interface avant de l'ajouter.
- Garantir la réversibilité et ne pas écraser la version Android installée.
- Traiter séparément les findings de l'audit de provenance/licence ; ne pas masquer la règle `release_audit.py --strict`.

## 4. Chantier P1 : fonctions déjà existantes, expérience utilisateur

### P1-A — Évolutions au niveau 40

- Vérifier `trade_evo` activé/désactivé, Kadabra, Machopeur, Spectrum, Gravalanch, et un cas avec objet tenu.
- Contrôler le niveau de déclenchement et la consommation de l'objet uniquement si l'évolution réussit.
- Rendre le libellé FR auto-explicatif : « ÉVOLUTION SANS ÉCHANGE » avec aide « niveau 40 ; objet tenu si nécessaire ».
- Ne pas introduire un second algorithme d'évolution.

### P1-B — Jour/nuit et rencontres horaires

- Navigation prévue : Options → Monde → Horloge.
- Activer JOUR/NUIT = AUTO, HORLOGE ×1, VOIR HORLOGE = OUI ; activer POKÉMON SAUV. = HORAIRES séparément.
- Tester la transition 17–20 h puis retour à l'éclairage de jour ; tester ville, route, bâtiment et rendu voxel.
- Tester les rencontres horaires Route 102 sur les trois tranches documentées ; vérifier que les probabilités affichées suivent la table réellement active.
- Les changements de lumière et de rencontres sont indépendants ; documenter les états OFF/AUTO et ORIGINAL/TIMED.
- Tester la restauration `.clock`/`.clock.bak` avec la sauvegarde après arrêt/reprise.

### P1-C — Vitesse intelligente des combats

- Exposer le paramètre `battle_speed` dans Options → Combat (valeurs ×1, ×1,5, ×2, ×3, ×4 et idéalement SUIVRE VITESSE GÉNÉRALE).
- Vérifier le mapping réel R1/L1 et R2/L2 sur AYN Thor avant d'afficher une aide matérielle.
- Diagnostiquer séparément « indicateur de vitesse changé » et « accélération réelle du moteur » ; mesurer le FPS jeu et les temps de réponse des menus.
- Étudier le comportement **PokeDaisy** : vitesse élevée pendant animation/combat, retour vitesse normale dans les menus et lors du choix d'action. C'est une référence fonctionnelle, **pas un code intégré**.

## 5. Chantier P2 : PokéNav dynamique par zone

### Sources et comportements

- Lire la **carte en cours**, la méthode active (herbe, Surf, Éclate-Roc, cannes), le moment du jour, la météo et les transformations de rencontres actives.
- Montrer les niveaux et taux de slots tels que calculés ; annoncer la différence entre « poids du slot » et « chance d'une rencontre par pas ».
- Statut d'une espèce : inconnue `???` / vue / capturée. Ne pas afficher le nom d'une espèce jamais vue si le mode anti-spoiler est actif.
- Respecter les Pokémon obtenus par échange/don, les rencontres spéciales et les formes qui ne sont pas dans les tables sauvages ordinaires.

### Objets, cadeaux et échanges

- Construire un index `(map_id, source_id, catégorie, conditions, flag/variable, règle_de_réapparition)`.
- Catégories : objets visibles, objets cachés, cadeaux PNJ, récompenses de scénario, échanges internes, objets/ressources renouvelables, baies.
- Afficher **disponible / obtenu / à nouveau disponible / verrouillé** selon le véritable flag ou timer, jamais selon une liste statique seule.
- Masquer les coordonnées précises des objets cachés. Un compteur de zone est acceptable ; aucune révélation prématurée.
- Si l'état n'est pas lisible de manière fiable, afficher « état inconnu » et non « récupéré ».
- Les échanges internes doivent vérifier si l'échange a déjà eu lieu et si ses conditions sont remplies.
- Ne pas inscrire des flags supplémentaires dans les octets existants de la sauvegarde sans étude explicite de rétrocompatibilité.

### Contrôles attendus

- Route 102 au début d'une partie : apparition de la table horaire active et des espèces `???` non vues.
- Capture : passage immédiat du statut « vu » à « capturé ».
- Objet récupéré : grisage après collecte et après recharge de la sauvegarde.
- Objet renouvelable : réapparition correctement détectée après événement/temps réel ; aucune fausse réapparition.
- Ville : offres d'échange, objets donnés, événements et conditions d'accès, sans spoiler excessif.
- Changement carte/heure/méthode : recalcul visible et performant, sans ralentissement de l'écran inférieur.

## 6. Chantier P3 : saisons et système temporel

- Étudier **Pokémon Emerald Crest** pour les fonctions d'une saison (visuel, rencontres, évolution, météo). Vérifier au préalable la disponibilité réelle et la licence de son code.
- Étudier les systèmes `pokeemerald-expansion` pour la réutilisation des mécaniques d'encounters/temps et des capacités de DexNav.
- Créer un module distinct, désactivé par défaut : printemps/été/automne/hiver, mode calendrier réel ou durée accélérée réglable.
- Distinguer **heure effective**, **calendrier d'événements du jeu**, **saison** et **timer de régénération**.
- Prévoir compatibilité voxels 3D, palettes 2D, baies, météo et sauvegarde ; concevoir test de rollback.
- Ne pas promettre le fonctionnement des quatre saisons sans preuve de build et de test.

## 7. Chantier P4 : extension narrative de la campagne — Acte II

**Exigence utilisateur (24/11/2026) :** le postgame doit être une véritable deuxième campagne, avec des éléments de scénario supplémentaires, pas seulement des combats ou huit nouveaux badges. L'intrigue ci-dessous est une piste de conception, non un scénario définitif ni une fonctionnalité livrée.

### P4-A — Conception narrative

- Déclencher l'Acte II après la première Ligue, sans modifier la campagne originale.
- Définir une intrigue principale avec introduction, progression en chapitres, conflits, révélations et conclusion.
- Propositions à étudier : retour à Bourg-en-Vol, anomalies climatiques à Hoenn, enquêtes autour des anciens membres des Teams Aqua/Magma, secrets de ruines et événements légendaires, dénouement avant ou autour de la Ligue renforcée.
- Intégrer des personnages inédits, des dialogues conditionnels, des quêtes principales et secondaires, des missions d'enquête, d'exploration, de livraison ou de résolution d'énigmes, des récompenses et des événements évolutifs.
- Faire évoluer certaines villes et certains PNJ en fonction des chapitres terminés. Étudier de nouvelles zones accessibles après la Ligue, selon la compatibilité du pipeline de cartes et du rendu Android/voxel.
- Les huit nouveaux badges constituent des jalons narratifs et de progression ; associer chaque arène à une mission ou un événement plutôt que d'imposer uniquement des recombats.
- Conserver les personnages et faits établis du jeu original ; écrire les nouveaux dialogues en français et prévoir leur localisation.

### P4-B — Architecture et prototype vertical

- Auditer d'abord les scripts d'événements, les flags/variables, les rematchs, les transitions de cartes, les callbacks et le PokéNav du moteur épinglé. Étudier les extensions existantes avant de créer un nouveau système de quêtes ; vérifier licence et provenance.
- Définir le graphe des chapitres, les prérequis, les déclencheurs, les dialogues conditionnels, les récompenses et les états persistants. Prévoir des transitions rejouables sans récompenses dupliquées ni blocage.
- Établir une matrice de compatibilité des sauvegardes avant tout nouveau flag/variable. Ne pas réutiliser d'identifiants occupés ni modifier arbitrairement la structure GBA. Évaluer une extension de persistance versionnée uniquement si nécessaire, avec restauration testée.
- Construire un premier chapitre jouable de bout en bout : événement après Ligue, dialogue, objectif hors combat, modification d'état du monde, récompense unique, sauvegarde puis reprise.
- Qualifier ce prototype sur Android FR / AYN Thor avant de développer les autres chapitres.

### P4-C — Campagne complète et Ligue

- Recombats scénarisés des huit champions avec nouvelles équipes, objets et IA.
- Ajouter huit **indicateurs de progression indépendants** des badges originaux ; leur représentation visuelle peut nécessiter de nouveaux assets et menus.
- Déverrouiller la Ligue renforcée selon l'avancement narratif et les jalons de progression ; proposer ensuite des cycles optionnels de difficulté.
- Conserver les badges originaux, les HM, l'accès aux zones et la progression de la première campagne.

### Critères de qualification P4

- Une sauvegarde pré-Ligue reste utilisable et ne déclenche pas l'Acte II prématurément.
- Une sauvegarde post-Ligue éligible permet de démarrer l'extension sans recommencer le jeu.
- Au moins un objectif significatif hors combat existe dans chaque chapitre ; les dialogues et l'état du monde reflètent la progression réelle.
- Sauvegarde/reprise au milieu des quêtes, récompenses non dupliquées, absence de blocage de progression, fonctionnement des nouveaux scripts et cartes sur AYN Thor.
- Aucune régression de la campagne initiale ni publication de données ROM privées.

**STATUS : À CONCEVOIR.** Développement P4 après stabilisation sauvegarde/Android, PokéNav et travaux temporels ; ne pas prétendre que ces chapitres sont déjà implémentés.

## Chantier P1-D — Qualification voxel 3D et corrections visuelles (24/11/2026)

**Exigence utilisateur :** corriger progressivement les anomalies visuelles du mode voxel existant, sans réécrire le moteur. Ce chantier est transversal et prépare aussi les nouvelles cartes de l'Acte II.

| ID | Anomalie rapportée sur AYN Thor | Hypothèses à vérifier | Critère d'acceptation |
| --- | --- | --- | --- |
| VOX-01 | PNJ debout sur les chaises au lieu de paraître assis | Ancrage vertical, position relative au siège, profondeur/occlusion, pose du sprite ou absence de pose assise | PNJ de chaises visés placés naturellement, sans traverser le mobilier ni modifier leur collision ou script |
| VOX-02 | Plants de baies surélevés par rapport à la terre | Ancrage au sol, transparence/padding du sprite, hauteur de terrain ou support de modèle | Pied du plant au niveau de sa parcelle à tous les stades de croissance ; sol et comportement des baies préservés |

Observations utilisateur ; emplacements exacts, captures, réglages et cause racine non encore établis. Ne pas supposer une correction unique ni modifier globalement la hauteur des sprites.

**Sources internes vérifiées :**
- `3ds_port/src/voxel/voxel_entities.c` : placement des sprites, padding des pieds, `ModelPush` et occlusion du mobilier, échantillonnage de relief, profondeur optionnelle des sprites.
- `3ds_port/src/voxel/voxel_world.c`, `voxel_relief.c`, `voxel_building.c` : géométrie et supports.
- `docs/VOXEL_GUIDE.md`, `docs/VOXEL_MOUNTAINS.md`, `docs/VOXEL_STATUS.md` : guides, couverture et limites connues ; le sol des baies doit rester un sol et ne pas être retouché comme relief.
- `3ds_port/assets/voxel/relief_fixes.json`, scripts `gen_voxel_relief.py`, `voxel_scene.py`, `voxel_view_scan.py`, `voxel_relief_check.py` : réutiliser corrections par données et outils existants selon le cas, sans supposer que les outils de relief reproduisent à eux seuls les PNJ.

**Méthode :**
1. Relever carte/layout, cellule/objet, capture et paramètres caméra/profondeur ; comparer avec le mode 2D. Identifier si le PNJ est censé être assis et si son sprite possède une pose adaptée.
2. Reproduire avec rendu déterministe ou fixture ciblée, isoler ancrage, support, pose et occlusion. Préférer une règle de placement correcte ou des métadonnées spécifiques à un décalage global.
3. Ajouter des tests de non-régression (PNJ debout, assis, joueur, mobilier, baies à plusieurs stades, pentes et passages, ombres, caméra, profondeur 0/1/2/3 si disponible).
4. Vérifier la compilation et le pipeline FR/recette/voxel, puis comparer avant/après sur Thor. Préserver mode 2D, collisions, scripts, croissance des baies et sauvegardes.
5. Constituer un registre des anomalies voxel par carte/objet, dédupliquer les causes communes et traiter par lots. Réutiliser les outils du dépôt avant développement supplémentaire.

**État :** à diagnostiquer. Aucun correctif voxel de ces deux anomalies livré ; la résolution du défaut SAVE reste prioritaire.

## 8. Références de réutilisation (à auditer, pas à copier automatiquement)

- **Portage existant :** https://github.com/Cer0-D/emerald-android
- **Portage dual-screen alternatif :** https://github.com/Goldoire/pokeemerald-dualscreen
- **Fast-forward intelligent :** https://pokedaisy.com/docs/fast-forward/ et https://github.com/DonovanSwinthrop/thor-companion
- **Moteur étendu :** https://github.com/rh-hideout/pokeemerald-expansion
- **ROM hack avec saisons :** https://thatsimpledev.itch.io/emerald-crest
- **Roguelite avec fonctionnalités connexes :** https://github.com/Pokabbie/pokeemerald-rogue

**Garde de réutilisation :** relever le commit exact, la licence du morceau réutilisé, ses dépendances, l'impact sur le `pokeemerald` épinglé et les ressources redistribuables. Les licences ou la disponibilité des sources non vérifiées restent **à étudier**.

## 9. Livraison et critères STOP

- **STOP** si la compilation ou les tests échouent ; ne pas installer un APK non testé comme mise à jour de la version stable.
- **STOP** si provenance/licence de fichiers requis à la distribution non régularisées.
- **STOP** si un changement de sauvegarde nécessite une migration sans preuve de restauration.
- **STOP** si le paquet Android de développement remplace l'application installée par erreur.
- Sur Android, une sauvegarde importée doit appartenir à l'UID de l'application. Le cas `EACCES errno=13` a déjà été résolu localement par sauvegarde, création d'un fichier app-owned, écriture **en place**, comparaison SHA-256 et test d'enregistrement. Ne pas recommander `adb push` direct sur le fichier final.
- Les `*.sav`, `*.clock` et `*.clock.bak` de l'utilisateur restent hors dépôt.

**Ordre de travail :** P0 stabilité du fork/Android ; P1 réglages et tests ; P2 PokéNav ; P3 saisons ; P4 postgame.

## 10. Reprise GitHub du 22 novembre 2026 — suivi de réalisation

**Base contrôlée :** fork `main` et upstream `main` identiques au SHA `ba8ca267`.
Aucun merge sur `main`. Les PR #1 à #5 restent en brouillon et leurs validations restent indépendantes.

| PR | Branche | Commit de travail | État prouvé |
| --- | --- | --- | --- |
| [#1](https://github.com/Proginji2000/emerald-android/pull/1) | `feat/visited-city-markers` | `58800979` | `host-tests` PASS ; échec ASan `verify-pokedex-capture` sur run push `45047313756` |
| [#2](https://github.com/Proginji2000/emerald-android/pull/2) | `docs/emerald-extended-roadmap-20261122` | évolue avec cette passation | documentation, pas un build |
| [#3](https://github.com/Proginji2000/emerald-android/pull/3) | `fix/release-audit-provenance-20261122` | `ca7d966d` | `audit-and-python` PASS sur run `45050456744`; autres jobs non qualifiés |
| [#4](https://github.com/Proginji2000/emerald-android/pull/4) | `feat/battle-speed-options-20261122` | `ee834a5e` | test `Battle speed option registration` PASS sur run `45050810065`; suite des tests non verte |
| [#5](https://github.com/Proginji2000/emerald-android/pull/5) | `feat/map-display-mode-20261122` | `4e1fc36d` | `host-tests` PASS sur run `45050969611`; audit sans PR #3 encore FAIL |

La PR #5 est **empilée sur la branche de la PR #1**, pas directement sur `main`.
Elle ajoute `OPTIONS → MONDE → AIDES → AFFICH. CARTE`, valeurs CLASSIQUE par défaut / PROGRESSIVE.
Les marqueurs de la carte du mode Vol restent visibles dans les deux modes. Le choix utilise
`map_progressive` dans `settings.txt`; aucune migration de sauvegarde.

La PR #4 expose `OPTIONS → COMBAT → SCÈNE → VITESSE COMBAT` :
AUTO (suit la vitesse générale), ×1, ×1,5, ×2, ×3 et ×4.
Elle réemploie `CtrSettings_StepBattleSpeed` et la clé `battle_speed`, sans second moteur.
Le libellé français de `trade_evo` devient `ÉVOL. SANS ÉCHANGE`.
L'aide explicite « niveau 40, objet tenu si requis » reste à concevoir sans débordement UI.

**CI transversale :** avant le correctif PR #3, l'audit strict signale cinq icônes Android
sans provenance et `dlmalloc` sans fichier licence reconnu. La PR #3 ajoute les preuves,
sans modifier l'audit ; `audit-and-python` est PASS sur la branche #3.
Sur `main`, la fixture `bottom_map_test.py` échoue avec des constantes manquantes ;
les corrections de la PR #1 réparent le test hôte, mais sont encore non fusionnées.
L'échec ASan `SIGSEGV` de `pokedex_capture` n'a pas de diagnostic C complet ;
aucun sanitizer ne doit être désactivé pour masquer le problème.

**Intégration contrôlée :** qualifier PR #3 (audit) et PR #1 (fixture/carte), puis PR #5
(empilée), et rebaser/qualifier PR #4 après intégration des prérequis.
Ne fusionner aucune PR avant vérification des checks sur le commit à merger et
acceptation des risques. Rafraîchir les résultats CI avant toute conclusion globale.

### Procédure Android à qualifier (Aucune compilation exécutée à cette date)

Le script officiel `android_port/tools/build.sh` recherche les ROMs propres par SHA-1.
Pour le français, le SHA-1 attendu est `ca666651374d89ca439007bed54d839eb7bd14d0`.
Il utilise le checkout courant, un toolchain Android NDK, les outils devkitARM,
le bootstrap du `pokeemerald` épinglé, les dépendances de génération et les recettes.

**Sur une machine disposant déjà des prérequis et de la ROM française personnelle :**

```bash
LANGS=fr bash android_port/tools/build.sh --roms "/chemin/vers/roms" --no-install
```

Ce mode construit, sous réserve des dépendances, `build/android-dev/emerald-android-dev.apk`
avec package `com.cer0.emerald.dev`. **Ne pas utiliser `--release`** pour les essais :
la publication utilise `com.cer0.emerald` et pourrait remplacer l'application stable.
Le script `android_port/tools/dev_rom.sh` existe mais transfère une ROM dans
`Android/data/com.cer0.emerald.dev` via shell ; vérifier lecture et ownership Android
sur AYN Thor avant tout usage. Ne pas copier la sauvegarde officielle dans le profil dev
sans sauvegarde, empreinte et procédure de restauration vérifiées. Aucun APK de développement
n'a été construit/testé pendant cette reprise ; la CI courante ne compile pas d'APK Android.

## 11. Inventaire initial des projets de réutilisation

**Constat GitHub du 22/11/2026.** Il s'agit d'une vérification d'existence,
de licence apparente et d'adéquation générale ; **aucun code ni asset n'a été réutilisé**.

| Source | Constats vérifiés | Décision |
| --- | --- | --- |
| [Goldoire/pokeemerald-dualscreen](https://github.com/Goldoire/pokeemerald-dualscreen) | Repo public actif, portage natif Android double écran AYN Thor. `LICENSE` MIT **limité aux modifications originales du port** ; contenu Pokémon et tiers exclus. README précise expérience vanilla et ROM USA/Europe, sans prise en charge de hacks. | Référence utile pour l'UI et la disposition ; audit par fichier et compatibilité FR requis avant portage. |
| [rh-hideout/pokeemerald-expansion](https://github.com/rh-hideout/pokeemerald-expansion) | Base de ROM hack avec fonctions modernes, dérivée de `pret/pokeemerald`. README demande de créditer RHH et indique un risque d'incompatibilité multijoueur avec les jeux officiels. Aucun fichier `LICENSE` racine dans l'inventaire consulté (des droits peuvent être définis ailleurs). | Audit fonctionnel/licence fichier par fichier, delta du `pokeemerald` épinglé et migration de sauvegarde avant tout import. |
| [DonovanSwinthrop/thor-companion](https://github.com/DonovanSwinthrop/thor-companion) | Dépôt public avec licence GPLv3 en racine. | Utiliser comme référence comportementale du fast-forward intelligent ; ne pas copier du code sans analyse de compatibilité et d'obligations GPL. |
| [Pokabbie/pokeemerald-rogue](https://github.com/Pokabbie/pokeemerald-rogue) | Dépôt public ; branche par défaut `vanilla`, README de décompilation `pokeemerald` et non spécification directe des fonctions Rogue. Pas de `LICENSE` visible à la racine lors de l'inventaire. | Identifier la bonne branche/tag et provenance de chaque module avant étude technique ; aucune réutilisation autorisée par simple existence du repo. |
| Pokémon Emerald Crest | Jeu et références documentés, mais aucun audit de code source ou licence exécuté dans cette reprise. | **BLOCKED** pour import de code/assets jusqu'à preuve explicite d'accès aux sources et des licences. |

**Référence du port :** `upstream.lock` épingle `pret/pokeemerald` au commit
`76463dac15cad36aca5e2b3f6366abf9e53f814f`. Une fonction disponible
dans une autre base ne constitue donc pas une preuve de compatibilité
binaire, de scripts, de flags ou de sauvegarde. Ne jamais fusionner
directement un moteur d'expansion complet sans protocole de migration.

## 12. Validation CI de la base intégrée et préparation Android

**2026-11-22 — GitHub Actions :**
`integration/ayn-thor-preview-20261122`, SHA `a075c2c5` :
run https://github.com/Proginji2000/emerald-android/actions/runs/45051243446
**SUCCESS** (jobs `host-tests`, `build-3ds`, `audit-and-python` PASS).
Il s'agit de la **compilation 3DS**, non d'une compilation Android.
L'artifact `emerald3ds-engine` n'est pas un APK.

**Outil d'étape suivante :**
[PR #6](https://github.com/Proginji2000/emerald-android/pull/6),
`tooling/android-fr-preflight-20261122`, SHA `22d31c99`,
base `integration/ayn-thor-preview-20261122`. Le script
`android_port/tools/preflight_fr.sh` valide les dépendances locales et le SHA-1
de la ROM BPEF avant d'autoriser `--build`, avec `--no-install` obligatoire.
Voir `docs/AYN_THOR_DEV_BUILD.md`.
Son run PR `45075917876` a **`host-tests` PASS** (y compris test de
précontrôle sur fausse ROM synthétique) et **`audit-and-python` PASS** ;
`build-3ds` était encore en cours à la consultation. **Aucun APK Android
n'a été produit**, et aucun essai matériel AYN Thor n'a été effectué.

**Garde de livraison :** la ROM française personnelle n'est jamais placée
dans GitHub ou un artifact CI public. La compilation Android s'effectue
localement et produit un package de développement `com.cer0.emerald.dev`,
qui doit être contrôlé avant installation. Préserver la version officielle
`com.cer0.emerald`, sa sauvegarde et les fichiers auxiliaires d'horloge.
