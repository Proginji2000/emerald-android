# Emerald Extended — Charte de fidélité au jeu original

**Statut :** exigences de conception, 24 novembre 2026. Aucun nouveau contenu qualifié. Références proposées à étudier dans la base locale épinglée, pas un audit des cartes déjà effectué.

## Principe directeur

L'Acte II doit donner l'impression d'une extension naturelle de Pokémon Émeraude, et non d'un ROM hack visuellement ou mécaniquement étranger à Hoenn. Les nouveautés restent distinctes de la campagne originale et ne doivent pas dégrader celle-ci.

## Référentiel vanilla avant production

Pour chaque nouvelle carte ou modification, relever dans deux ou trois cartes comparables : dimensions, densité des obstacles, tilesets, distribution des chemins, collisions, niveaux de terrain, connexions, sorties, position des PNJ/dresseurs/objets, rencontres, temps de traversée, fréquence des combats et rythme exploration/repos. Utiliser le moteur et les données locales légalement disponibles ; ne pas publier de données ROM ou d'assets protégés.

Exemples de références à vérifier : routes 119/120 (forêt), 114/115 (montagne et côte), 112 et Sentier Sinuroc (volcan), 124–134 (mer et courants), Grotte Granite et Site Météore (grottes), désert de la route 111 et ruines des Regis (énigmes), Poivressel/Nénucrique (villes côtières), Myokara/Autéquia (localités isolées). Les références doivent être adaptées à la fonction de chaque carte.

## Règles de production

- Préférer les tilesets, palettes, motifs de terrain, conventions de placement et mécaniques déjà présents. Les nouveaux motifs ou sprites originaux doivent respecter les proportions, le style pixel art et les palettes du jeu.
- Concevoir des chemins lisibles, des embranchements motivés par l'exploration, des points de repère et des raccourcis cohérents ; éviter cartes surdimensionnées, obstacles arbitraires, labyrinthes artificiels et combats trop denses.
- Les changements de route, passages orientés et déviations post-Ligue doivent être justifiés par le récit, signalés au joueur et testés dans chaque état de progression.
- Adapter rencontres, objets, dresseurs, personnages et dialogues français au lieu, à l'histoire et au ton du jeu original. Créer des dialogues nouveaux plutôt que recopier des textes existants.
- Les arènes et la seconde Ligue doivent conserver leur identité thématique et les règles du jeu, tout en renouvelant leurs épreuves et équipes.
- Réutiliser scripts et mécanismes existants après contrôle de compatibilité et de licence. Ne pas supposer que les recettes Android peuvent intégrer de nouveaux contenus sans qualification.

## Contrôle obligatoire par carte

1. Présenter les références vanilla et expliquer les choix de conception.
2. Produire un plan et un rendu comparatif local (2D, puis voxel si applicable).
3. Tester connexions, collisions, warps, sens de passage, capacités de déplacement, sorties sûres et absence de softlock dans chaque état de chapitre.
4. Vérifier les événements, les rencontres, les récompenses et les dialogues ; tester sauvegarde/reprise, compatibilité pré-Ligue et retour après défaite.
5. Faire relire par un agent distinct du concepteur, puis qualifier le rendu et le parcours sur AYN Thor. Une compilation réussie ne suffit pas à valider la qualité du level design.

**Acceptation :** la nouvelle zone est reconnaissable comme appartenant à Hoenn, possède une fonction narrative ou ludique identifiable, respecte les conventions mesurées des zones comparables et s'intègre sans rupture au monde d'origine. La cohérence esthétique et le plaisir de jeu nécessitent une validation visuelle et humaine ; aucun seuil arbitraire de densité n'est imposé avant analyse du référentiel.
