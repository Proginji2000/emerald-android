# Emerald Extended — Acte II : conception consolidée V0.2

24 novembre 2026. Statut : proposition de conception après revue de cohérence. Aucun développement, test matériel, ni audit complet des cartes/flags n'est déclaré terminé. Les exigences utilisateur ci-dessous sont retenues ; noms, ordre, lieux nouveaux, intrigue précise et chiffres sont des propositions révisables. Ce document est le référentiel commun des tickets #22–#28 ; la [charte vanilla](EMERALD_EXTENDED_LEVEL_DESIGN.md) reste obligatoire.

## 1. Exigences et identité
- Première campagne, Panthéon, badges, événements et Zone de Combat préservés ; démarrage de l'Acte II après première victoire et séquences post-Ligue vanilla nécessaires, y compris gestion du choix Latias/Latios et Passe Bateau. Ne pas imposer la capture d'un légendaire.
- Hoenn évolutif : nouvelles routes terrestres/maritimes, chemins oubliés, passages orientés, déviations scénarisées, raccourcis et nouveaux lieux. Prendre les cartes vanilla comme référence ; pas de refonte arbitraire de la région.
- Huit nouvelles épreuves, huit badges de maîtrise indépendants, tous les champions ET dresseurs d'arène revus ; Conseil 4 et Maître de seconde Ligue revus.
- Finale à retournement narratif au sein de la Ligue, inspirée de la structure de Noir et Blanc, sans recopier le scénario.
- Deoxys, Île Aurore et adaptation originale de l'Épisode Delta. Préserver le puzzle et le mécanisme de rencontre d'origine.
- Scénario FR original, dialogues, PNJ, énigmes, objectifs hors combat. Maintenir identité troisième génération, pas de Méga-Évolution présumée.

## 2. Fil rouge proposé
Titre de travail : L'Héritage de Hoenn. Horizon se présente comme un consortium scientifique de prévention des catastrophes. Ses expérimentations sur un réseau ancien amplifient les perturbations déclenchées après la crise Groudon/Kyogre ; elles ne doivent pas contredire le retour à l'équilibre de la première campagne. Les sanctions environnementales constituent des conséquences de ces expériences, non des portes arbitraires. Le fragment extraterrestre est une source de données/énergie convoitée par Horizon, pas une deuxième apocalypse indépendante. L'arc Deoxys dévoile le projet de contrôle à distance et prépare la finale.

Le joueur demeure vainqueur de la première Ligue. Proposition : Marc dirige provisoirement le circuit officiel/Conseil 4 à la demande de la Ligue pendant les missions du joueur ; le nouveau tournoi attribue un titre distinct de maîtrise. L'antagoniste défie Marc comme responsable du tournoi, non comme si le joueur n'avait jamais gagné. Un combat gagné ne confère pas automatiquement l'autorité politique sur Hoenn. Horizon veut contrôler les installations et profiter de la réunion des champions ; sa revendication de légitimité est un prétexte. Pierre est allié scientifique ; Juan reste champion d'Atalanopolis. Les anciens Aqua/Magma peuvent fournir informations et aide, sans reproduire leur intrigue initiale. Docteur Aster, Iris, Horizon et adaptation éventuelle d'Amaryllis restent des noms/pistes à valider.

## 3. Circuit proposé (pas un plan de cartes validé)
Un prologue + huit jalons d'arène + finale distincte. Chaque jalon inclut mission hors combat, route/zone et épreuve d'arène. Ordre volontairement différent du vanilla ; les connexions inédites nécessitent conception et qualification. Les chenaux portent leur appellation française. Les portes d'arène et les objectifs sont protégés par l'état narratif, pas par la suppression globale de Vol.

| Phase | Secteur / circuit à étudier | Mission et effet | Badge |
| --- | --- | --- | --- |
| Prologue | Bourg-en-Vol / Clémenti-Ville | Seko, premier incident, statut du joueur, journal | — |
| 1 | Clémenti-Ville / routes 102–104 et chemins secondaires | Aider habitants et établir le lien entre incidents | Norman |
| 2 | Chenaux 105–109 / Myokara | Circuit côtier, Grotte Granite, premier indice ancien | Bastien |
| 3 | Mérouville / route 115 et nouveau chemin vers la côte | Enquête Devon, mine et découverte d'un équipement Horizon | Roxanne |
| 4 | Routes 113–114 / secteur volcanique / Vermilava | Nouvelle déviation montagneuse, sécuriser une zone, témoignages Magma | Adriane |
| 5 | Route 111 / Lavandia / New Lavandia | Réparer réseau et identifier le détournement d'énergie | Voltère |
| 6 | Routes 119–120 / Cimetronelle | Institut Météo, sentiers forestiers, dévoiler le réseau | Alizée |
| 7 | Nénucrique / chenaux vers Algatia / Centre Spatial | Signal et enquête maritime, préparer l'arc Aurore | Lévy et Tatia |
| Interlude | Site Météore / Pilier Céleste / Île Aurore | Arc Deoxys, obtenir le ticket par quête, révéler l'objectif final ; capture facultative | — |
| 8 | Chenaux 124–134 / Atalanopolis | Sanctuaire, désactiver une partie du réseau, découvrir le plan de la Ligue | Juan |
| Finale | Éternara / Ligue | Conseil 4, interruption, crise, confrontation, épilogue puis tournoi récurrent | — |

Le jalon 8 ne clôt pas l'intrigue principale : il résout une étape du projet Horizon et fournit la preuve menant à la Ligue. La confrontation décisive a lieu à Éternara une seule fois. Le tournoi normal se débloque ensuite sans rejouer la crise. Le nombre de cartes et la durée annoncés en discussion (25–40 et 15–25 h) sont des cibles exploratoires, à recalibrer après le pilote.

## 4. Contrats de progression
- Graphe orienté par chapitre, états de carte et prérequis ; chemins de retour sûrs après passage à sens unique, Vol/Surf/Plongée/CS, Téléport, défaite, retour Centre Pokémon et reprise. Vérifier accès à la Zone de Combat et aux lieux vanilla. Les nouvelles zones ne sont pas accessibles prématurément par Vol.
- Les saisons sont optionnelles (#20). Toute quête obligatoire possède un parcours indépendant du calendrier réel et du réglage saisonnier ; les modifications indispensables sont déclenchées par des flags narratifs. Jour/nuit, météo et saisons ne sont pas synonymes.
- Le journal de missions du PokéNav est à spécifier (objectif, indice, statut, reprise, pas de spoiler) ; intégrer les nouvelles cartes aux rencontres, objets et carte progressive (#12/#18/#19). Auditer les limites actuelles de marqueurs/compteur, identifiants, données et rendu avant extension.
- Les huit badges supplémentaires ne doivent pas réattribuer les CS ni modifier l'obéissance vanilla ; gérer inventaire/affichage et progression indépendamment. Inventorier flags/vars, limites d'IDs, espace de sauvegarde et compatibilité avant d'allouer. Aucun changement du format 128 Kio sans décision et migration qualifiée.
- Définir règles de difficulté à partir des équipes de fin de Ligue, progression graduelle, options de revanche et entraînement ; éviter une courbe qui atteint trop tôt le niveau 100. Évaluer équipes, capacités, talents, objets, IA et combats doubles selon les règles réellement disponibles. Distinguer progression fixe et éventuels modes de difficulté.
- Événements uniques idempotents : anciennes sauvegardes, import, abandon de quête, fuite, K.O., capture passée, nouvelle rencontre et récompense. Pas d'écrasement des flags vanilla ni de duplication de légendaire. Deoxys est niveau 30 et forme Vitesse dans la version originale ; toute modification doit être explicite et motivée. Distinguer capture de Rayquaza et aide narrative.
- Les autres événements (Mew, Lugia, Ho-Oh, Jirachi) sont des pistes hors périmètre actuel, non assimilées à des événements vanilla identiques. Jirachi nécessite une conception distincte. Ne pas en faire des prérequis.

## 5. Dépendances et étapes de production
#24 est le ticket parent d'intégration de campagne, pas un prérequis de ses propres sous-chantiers. #22 (conception) peut avancer en parallèle de #21 (outillage) et P0. Les diagnostics et builds nécessaires à #8 peuvent utiliser #9 sans attendre sa qualification finale ; celle-ci reste bloquée par #8.
- Préparation : #8 sauvegarde, #9 qualification build/ADB ; #17 outillage voxel avec cas #15/#16 ; #21 qualification éditeur/scripts/FR/voxel. #22 fournit contrat narratif et progression.
- #23 pilote : route nouvelle + modification d'accès + petit donjon + PNJ/dialogues + énigme + dresseurs + récompense + sauvegarde/reprise ; tester avant/après Ligue, FR, 2D/voxel et Thor.
- #25 monde, #26 arènes, #28 Deoxys et #27 finale : conception parallèle, production après #23. #27 finale intégrée après jalons monde/arènes/Deoxys ; #28 coordonne avec #27 sans dépendance inverse bloquante. #24 clôture lorsque sous-chantiers et intégration complète sont validés.
- Preuves : audit graphe, assertions des états, scénarios record/play à qualifier, captures locales, test matériel et appréciation du joueur.

## 6. Risques techniques constatés
La documentation ASSET_PIPELINE.md sépare layouts, scripts, gamedata et voxel ; les packs dépendent de l'ABI et les recettes vérifient les données. FRENCH.md indique que les manifestes localisés sont liés aux empreintes des fichiers source. Ajouter des cartes et scripts originaux nécessite qualifier la génération FR, les données, ABI, recettes et audits, sans distribuer ROM ni assets protégés. Une compilation seule ne prouve pas la capacité à produire du nouveau contenu. La PR #7 au commit 1d27ad64 est encore ouverte ; run 45270004191 : build-3ds FAIL, host-tests/audit PASS. Défaut SAVE non résolu et liaison WSL/ADB non qualifiée selon le dernier état documenté.

## 7. Références vérifiées
- https://www.pokepedia.fr/Conseil_4 et https://www.pokepedia.fr/index.php/Hoenn : Marc, Juan, Conseil 4.
- https://www.pokepedia.fr/Ile_Aurore et https://www.pokepedia.fr/%C3%89pisode_Delta : événement et inspiration.
- https://www.pokebip.com/page/jeux-video/pokemon-emeraude/capture-lugia-ho-oh-deoxys : ticket, île, forme.
- https://www.pokekalos.fr/jeux/gba/emeraude/map/ : noms des secteurs, pas validation des connexions proposées.
