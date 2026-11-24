# Emerald Extended — Contrat de compatibilité et légalité V0.3

**Statut :** exigences validées par l'utilisateur, architecture et tests à qualifier. Prioritaire sur le volume de contenu. Ni PKHeX ni échange réel ni aller-retour de sauvegarde Extended n'ont été testés dans cette passe.

## Invariants
- Pokémon Émeraude FR BPEF, sauvegarde GBA Flash 128 Kio, structures, checksums, slots, identifiants et valeurs Gen III conservés. Ne jamais modifier IV/EV/PID, OT/TID/SID, origine, lieu/niveau de rencontre ou autres attributs pour masquer une provenance incompatible.
- Toutes les espèces, formes, capacités, objets tenus, évolutions et rencontres doivent être compatibles avec les règles officielles Gen III, y compris les distributions historiques, contraintes de langue/version, RNG/PID/IV, fateful encounter et shiny selon le cas. La réussite PKHeX n'est ni une preuve de provenance authentique ni une garantie de tous les échanges.
- Conserver les fichiers originaux intacts ; données de progression Extended dans un fichier complémentaire versionné est la piste privilégiée. Auditer atomicité, cohérence save/sidecar, identifiant de sauvegarde, migration, pertes, sauvegarde interrompue, absence de sidecar, import, RTC et rollback. Aucun choix technique irréversible avant prototype.
- La sauvegarde brute créée dans une nouvelle carte peut être incompatible avec la ROM originale même si son format est valide. Définir export explicite vers une position vanilla sûre, sans objets/IDs non reconnus, avec conservation de l'équipe, boîtes, inventaire compatible, Panthéon et données vanilla ; ne jamais prétendre que toute sauvegarde brute est directement portable. Préserver la progression Extended à part et définir réimport/réconciliation sans duplication, ni écrasement silencieux.
- L'utilisateur souhaite les 386 obtenables sans échange externe ET légaux. Ces objectifs peuvent entrer en conflit (rencontres hors région, trades PNJ personnalisés, distributions réservées à d'autres versions/langues). Légalité prioritaire. Ne pas forger de lieu de capture ou de distribution. Documenter les espèces sans solution et demander décision avant de modifier ces contraintes. Une quête peut donner accès à une méthode officielle existante, mais ne devient pas officielle pour autant.

## Matrice des méthodes d'obtention
Construire un inventaire versionné 386 lignes, avec espèce, version/langue d'origine, méthode, emplacement, niveau, prérequis, contraintes RNG, évolution, état vanilla, méthode Extended envisagée, cas de test, résultat PKHeX, provenance réelle, éventuel blocage. Vérifier sources et code du moteur épinglé. Distinguer œufs, cadeaux, échanges, rencontres, fossiles, starters, événements, migrations et distributions.
- Échanges PNJ définitifs : Pokémon reçu qui évolue si applicable, pas de retour de celui donné. Un trade personnalisé peut être rejeté ; vérifier la provenance/identifiants du Pokémon réellement obtenu. Option existante évolution niveau 40 non conforme au gameplay classique : isoler/désactiver en mode strict après audit.
- Rencontres dynamiques : modifier disponibilité ou accès seulement pour méthodes légales démontrées ; le niveau des Pokémon sauvages ne suit pas arbitrairement la difficulté des dresseurs. Nouvelles cartes peuvent être exploration sans capture inédite si nécessaire.
- Deoxys : préserver rencontre Île Aurore, niveau 30 et contraintes du jeu ; gérer états antérieurs, fuite, K.O., retour, sans duplication involontaire. Ticket accessible via quête si compatible ; distinguer accès reconstitué et authenticité de distribution. Mew/Jirachi/Celebi/Lugia/Ho-Oh et autres événements à qualifier séparément.

## Qualification (avant production de contenu)
1. Fixer version PKHeX/PKHeX.Core et format de rapport local, construire fixtures à partir de sauvegardes appartenant au joueur, données synthétiques de test clairement séparées. Ne publier ni save, ROM, Pokémon privés, ni secrets.
2. Contrôler sauvegarde vanilla → Extended → export vanilla → ouverture réelle sur ROM originale → nouvelle sauvegarde vanilla → réimport Extended. Contrôler taille, checksums, slots, positions, équipe, boîtes, inventaire, Panthéon, flags vanilla, RTC, identifiants et état complémentaire.
3. Tester sauvegarde en nouvelle carte, combat, récompense, échange, après perte de fichier complémentaire, interruption, réimport et retour de version ; définir états autorisés et STOP en cas de données incohérentes.
4. Vérifier cas positifs/négatifs PKHeX, analyse espèce par espèce et des Pokémon effectivement produits par le jeu ; tester échanges réels dans les deux sens sur supports compatibles, avec fixtures séparées. L'échange natif Android↔GBA n'est pas présumé disponible : auditer transport, sinon qualifier via sauvegarde et émulateur/jeu original.
5. Établir rapport local avec versions, hash de build, tests, résultats et limites. Échec ou absence de preuve = FAIL/BLOCKED, jamais PASS. Pas de correction automatique de la provenance par un outil de légalisation.

## Portes de décision
- #8 résout d'abord le défaut de sauvegarde Android, #9 fournit compilation/test et ADB qualifiés.
- L'audit de la matrice et des structures peut commencer sans Thor. L'architecture finale, le pilote #23 et la production de nouvelles rencontres exigent qualification compatible.
- Toute nouvelle génération (Acte III éventuel) doit faire l'objet d'une décision séparée : un Pokémon Gen IV ne peut pas être représenté dans Émeraude original. Pas de promesse de compatibilité intégrale pour ce futur périmètre.
