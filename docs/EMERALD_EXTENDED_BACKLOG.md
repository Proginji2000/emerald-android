# Emerald Extended — Backlog opérationnel

Date de cadrage : 24 novembre 2026. **18 issues GitHub ouvertes et référencées ci-dessous.** Les identifiants EE restent stables ; les numéros # sont les tickets GitHub réels. Priorités P0 à P4 et labels de chantier. Chaque ticket doit relier ses PR, preuves CI et tests matériels ; aucun PASS sans preuve.

## P0 — Base stable

### EE-001 — [P0-SAVE] Sauvegarde et import Android FR
**Issue :** [#8](https://github.com/Proginji2000/emerald-android/issues/8).
**Type :** bug bloquant. **État :** FAIL matériel ; PR #7 ajoute un diagnostic, pas une résolution. 
- [ ] Conserver les copies Dev, officielles et horloge ; reproduire l'erreur et examiner errno, UID, format et emplacement. Diagnostiquer aussi l'écran bleu illisible.
- [ ] Corriger la cause et qualifier sauvegarde neuve, fermeture/reprise, import contrôlé et restauration.
- [ ] Acceptation : aucune perte ni écrasement de la sauvegarde officielle, tests Thor PASS.
**Dépendances :** aucune.

### EE-002 — [P0-CI] Intégration et qualification Android FR
**Issue :** [#9](https://github.com/Proginji2000/emerald-android/issues/9).
**Type :** infrastructure. **État :** premier APK 0667b39 compilé et démarré ; PR #6/#7 ouvertes. 
- [ ] Recontrôler CI sur le commit exact ; diagnostiquer les échecs intermittents sans supprimer les tests.
- [ ] Compiler localement avec ROM personnelle et préflight ; vérifier signature/package Dev.
- [ ] Retester carte, commandes, sauvegarde, horloge et reprise ; documenter preuve et rollback.
**Dépendances :** EE-001 pour qualification finale. Pas de ROM/save/APK privé sur GitHub.

### EE-003 — [P0-UPSTREAM] Synchronisation des deux projets sources
**Issue :** [#11](https://github.com/Proginji2000/emerald-android/issues/11).
**Type :** maintenance récurrente. **État :** politique préparée dans [UPSTREAM_SYNC.md](UPSTREAM_SYNC.md).
- [ ] Surveiller Cer0-D main/releases et ZallaxDev main/releases ; dev/integration comme veille non stable.
- [ ] Classifier les changements, éviter doublons 3DS déjà portés et ouvrir PR de qualification séparée.
- [ ] Tester FR, recettes, ABI, voxel, sauvegardes, licences et CI avant promotion.
**Acceptation :** baseline, delta et preuves traçables ; jamais de merge automatique sur main.

## P1 — Corrections et fonctions existantes

### EE-004 — [P1-MAP] Carte classique/progressive
**Issue :** [#12](https://github.com/Proginji2000/emerald-android/issues/12).
**État :** PR #7 correctif source, retest requis. Vérifier compteur, marqueurs visités, carte classique, zoom, redessin, Vol. 
**Acceptation :** progression réelle et aucun artefact sur Thor ; sauvegarde intacte. **Dépendances :** EE-002.

### EE-005 — [P1-SPEED] Accélération et commandes de combat
**Issue :** [#13](https://github.com/Proginji2000/emerald-android/issues/13).
**État :** vitesse générale et combat ×4 observés PASS ; PR #7 route ZL/ZR selon la scène. 
- [ ] Tester AUTO, 1/1.5/2/3/4×, L/R, ZL/ZR, menus, retour au terrain et sessions link.
- [ ] Étudier un mode intelligent animations rapides / sélection d'action normale, sans dupliquer le moteur.
**Acceptation :** vitesse combat et terrain indépendantes, réglage dynamique fiable. **Dépendances :** EE-002.

### EE-006 — [P1-CLOCK] Horloge, cycle jour/nuit, évolutions
**Issue :** [#14](https://github.com/Proginji2000/emerald-android/issues/14).
**État :** fonctions existantes ; validation du build courant à faire.
- [ ] Jour/nuit, horloge, rencontres horaires Route 102, sauvegarde/reprise de l'horloge et baies.
- [ ] Vérifier évolution sans échange niveau 40, avec/sans objet, libellé français.
**Acceptation :** tests Thor et absence de régression. **Dépendances :** EE-001/002.

### EE-007 — [P1-VOX-01] PNJ debout sur les chaises
**Issue :** [#15](https://github.com/Proginji2000/emerald-android/issues/15).
**Type :** bug visuel, observation utilisateur ; cause non établie.
- [ ] Capturer carte/objet, comparer 2D/3D, pose, ancrage, ModelPush, profondeur et occlusion.
- [ ] Corriger par règle ou données ciblées, tester PNJ assis/debout, joueur, mobilier.
**Acceptation :** rendu naturel sans modifier collisions, scripts ni pose des autres PNJ. **Dépendances :** EE-002.

### EE-008 — [P1-VOX-02] Plants de baies surélevés
**Issue :** [#16](https://github.com/Proginji2000/emerald-android/issues/16).
**Type :** bug visuel, observation utilisateur ; cause non établie.
- [ ] Reproduire par parcelle et stade de croissance ; diagnostiquer ancrage et padding du sprite.
- [ ] Conserver le sol, les collisions et la croissance ; tests avant/après, caméra et profondeur.
**Acceptation :** pied du plant au niveau de la terre à tous les stades. **Dépendances :** EE-002.

### EE-009 — [P1-VOX-QA] Atelier qualification visuelle
**Issue :** [#17](https://github.com/Proginji2000/emerald-android/issues/17).
**Type :** outillage. Auditer voxel_scene.py, voxel_view_scan.py, voxel_relief_check.py et fixtures existantes ; étendre uniquement les lacunes. Registre par layout/cellule/objet, vues avant/après, contrôles relief, mobilier, éclairage, occlusion, performance et couverture 3D. 
**Acceptation :** reproduction déterministe, rapports lisibles, pas de faux PASS matériel. **Dépendances :** EE-007/008 comme cas de test, EE-002 pour validation.

## P2 — PokéNav dynamique

### EE-010 — [P2-DEXNAV] Rencontres, vu/capturé
**Issue :** [#18](https://github.com/Proginji2000/emerald-android/issues/18).
Réutiliser la liste existante, afficher taux par méthode/heure, niveaux et statut inconnu/vu/capturé. Respecter anti-spoiler, randomizer et rencontres spéciales ; distinguer poids de slot et chance par pas. 
**Acceptation :** Route 102, actualisation après capture et changement de méthode/heure, reprise. **Dépendances :** EE-001/002/006.

### EE-011 — [P2-ITEMS] Objets, cadeaux, échanges, ressources
**Issue :** [#19](https://github.com/Proginji2000/emerald-android/issues/19).
Indexer les sources par carte, flags, conditions et réapparition ; états disponible/obtenu/renouvelé/verrouillé/inconnu. Objets cachés sans coordonnées précises. 
**Acceptation :** grisage réel après collecte/reprise ; pas de faux statut ou duplication. **Dépendances :** EE-001/002/010.

## P3 — Temps et saisons

### EE-012 — [P3-SEASONS] Saisons optionnelles
**Issue :** [#20](https://github.com/Proginji2000/emerald-android/issues/20).
Audit des implémentations existantes, calendrier distinct de l'horloge, visuels/météo/rencontres, cohérence des baies et voxel. Concevoir prototype avec sauvegarde et rollback avant extension.
**Acceptation :** quatre saisons testées, aucune régression en mode OFF. **Dépendances :** EE-006/009/010.

## P4 — Extension narrative et atelier multi-agents

### EE-013 — [P4-TOOLING] Atelier Codex / Claude
**Issue :** [#21](https://github.com/Proginji2000/emerald-android/issues/21).
Auditer Porymap, Poryscript et autres outils compatibles avec le moteur épinglé ; qualifier édition cartes/PNJ/équipes/scripts, allocations d'identifiants, validation, captures, build, relecture croisée. Tester adaptation des manifestes FR et recettes/ABI/voxel. Aucun outil installé/qualifié par cette issue seule.
**Acceptation :** prototype reproductible sur une branche dédiée et aucune donnée ROM publiée. **Dépendances :** EE-002/009 ; conception peut démarrer en parallèle.

### EE-014 — [P4-STORY] Bible narrative et graphe de l'Acte II
**Issue :** [#22](https://github.com/Proginji2000/emerald-android/issues/22).
Définir intrigue cohérente, chapitres, PNJ, dialogues, missions hors combat, événements, exploration, récompenses et huit jalons de badges ; progression post-Ligue et dénouement. Les pistes Aqua/Magma, anomalies climatiques et légendaires ne sont pas des choix définitifs.
**Acceptation :** spécification validable, parcours et prérequis, compatibilité sauvegardes. **Dépendances :** conception indépendante ; réalisation après EE-013.

### EE-015 — [P4-PILOT] Premier chapitre jouable
**Issue :** [#23](https://github.com/Proginji2000/emerald-android/issues/23).
Prototype vertical : déclenchement après Ligue, nouveau PNJ, dialogue, objectif hors combat, modification de carte/événement, récompense unique, sauvegarde/reprise. Réutiliser scripts/flags après audit ; pas de modification arbitraire du format GBA. 
**Acceptation :** build FR, Android, tests progression, rollback et Thor PASS ; avant Ligue inchangée. **Dépendances :** EE-001/002/013/014.

### EE-016 — [P4-CAMPAIGN] Campagne complète, badges et Ligue renforcée
**Issue :** [#24](https://github.com/Proginji2000/emerald-android/issues/24).
Déployer par chapitre après validation du pilote ; nouvelles cartes/PNJ/équipes/énigmes/événements ; huit badges indépendants et nouvelle Ligue. 
**Acceptation :** chaque chapitre a un objectif hors combat, sauvegarde et reprise fiables, aucune régression de la campagne initiale, progression complète et conclusion. **Dépendances :** EE-015 et validation des systèmes requis.

### EE-017 — [P4-WORLD] Hoenn évolutif : routes, circuits et connexions post-Ligue
**Issue :** [#25](https://github.com/Proginji2000/emerald-android/issues/25).
Nouvelles routes, chemins terrestres et maritimes, routes oubliées réutilisées, passages orientés, connexions modifiées, raccourcis et déviations justifiés par le scénario. Graphe par chapitre avec prérequis, sorties sûres et protection contre les contournements par les capacités de déplacement ; campagne pré-Ligue préservée.
**Acceptation :** parcours alternatifs significatifs, absence de softlock, sauvegarde/reprise, 2D/voxel et PokéNav qualifiés. **Dépendances :** EE-013/014/015 pour réalisation ; coordination EE-016/009/010/011.

### EE-018 — [P4-GYMS] Refonte complète des huit arènes post-Ligue
**Issue :** [#26](https://github.com/Proginji2000/emerald-android/issues/26).
Revoir les huit champions et **tous les dresseurs** de leurs arènes, équipes, capacités, talents, objets, IA, dialogues, épreuves, missions d'accès et progression de difficulté. Ne pas limiter le changement aux niveaux. Préserver intégralement les arènes de la première campagne.
**Acceptation :** inventaire exhaustif et configuration post-Ligue distincte, huit badges indépendants, tests de défaite/reprise, aucun doublon de récompense ni régression. **Dépendances :** EE-013/014/015 ; coordination EE-016/017.

## Règles de gestion

- Une branche et une PR ciblée par lot cohérent, liées à l'ID. Pas de fusion automatique de code sur main.
- Réutiliser le code existant après revue de licence, provenance et compatibilité ; distinguer hypothèse, code proposé, CI, Android et preuve sur Thor.
- Les issues sont ouvertes ; utiliser les labels de type, priorité et chantier. Maintenir les dépendances et numéros réels. Aucun milestone GitHub créé à ce stade.
- Les [PR ouvertes](https://github.com/Proginji2000/emerald-android/pulls) restent le suivi des travaux déjà engagés. Roadmap détaillée et passation liées depuis le README.
