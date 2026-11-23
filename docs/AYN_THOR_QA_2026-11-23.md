# AYN Thor — qualification terrain et correctifs (23 novembre 2026)

## Contexte et périmètre

Fork Android FR, paquet isolé `com.cer0.emerald.dev`, ROM française BPEF privée (jamais ajoutée au dépôt). Première compilation locale depuis `0667b39` : APK v0.5.0.3 signé v3, checksum SHA-256 `1931368240bb747bf5f9bb20c156970f92254277fcfb1f28725905fdbb2b3b9d`. Installation sur AYN Thor et affichage de « Nouvelle partie » confirmés par l'utilisateur.

Cette note distingue **observé sur console**, **correctif source** et **validation encore à faire**.

## Observations sur l'APK initial

| Test | État | Preuve |
| --- | --- | --- |
| Installation, ROM FR, nouvelle partie | PASS | Retour utilisateur AYN Thor |
| Accélération générale | PASS | Retour utilisateur |
| Accélération de combat ×4 | PASS | Retour utilisateur |
| L/R et ZL/ZR pour régler indépendamment la vitesse combat | PARTIAL | Manipulation perçue comme inefficace |
| Carte progressive | FAIL | Aucun changement apparent après activation |
| Sauvegarde d'une nouvelle partie | FAIL | « erreur de sauvegarde, changez la mémoire de sauvegarde » |
| Import de la sauvegarde originale | NON QUALIFIÉ | Écran bleu / texte illisible, puis « Nouvelle partie » |
| Cycle jour/nuit sur cet APK | NON RETESTÉ | Fonctionnement observé sur version antérieure |

## Correctifs proposés dans cette branche

1. Android `android_input.c` : les touches ZL/ZR appellent `CtrPlatform_StepBattleSpeed` seulement lorsque la scène de combat est active ; la vitesse générale reste modifiable hors combat. Les touches L/R restent traitées par `3ds_game_bridge.c`.
2. Carte : seul un marqueur réellement visité est affiché en mode progressif, et un compteur `VILLES n/16` confirme l'état. Le mode classique et les destinations de Vol restent inchangés.
3. Sauvegarde : lorsqu'un fichier peut être lu mais pas ouvert en `r+b`, écrire une erreur explicite dans le journal, sans changer ses octets, ses droits ou son nom.

Les tests hôte de structure vérifient le routage des entrées et la distinction carte/Vol ; **aucun essai de la correction sur AYN Thor n'est encore exécuté**.

## STOP — préserver les données

- Ne jamais supprimer ni désinstaller `com.cer0.emerald`, son fichier `.sav` ni `.clock`/`.clock.bak`.
- La version Dev utilise ses propres fichiers sous `Android/data/com.cer0.emerald.dev/files/fr/`.
- Ne pas effacer les données Dev sans copie préalable des sauvegardes et des fichiers `*.not-emerald*`.
- Ne pas publier de ROM, `.sav`, `.clock`, `.pak` ni de logs bruts révélant des données privées.

## Diagnostic local de la sauvegarde Dev (sans écriture sur les saves)

1. Arrêter complètement Emerald Dev.
2. Avec l'outil de transfert déjà utilisé, ouvrir **uniquement** `Android/data/com.cer0.emerald.dev/files/fr/sdmc/3ds/emerald3ds/`.
3. Sauvegarder à part les fichiers `emerald3ds.sav`, `emerald3ds.sav.not-emerald*` s'ils existent, ainsi que `settings.txt`.
4. Créer dans **ce dossier Dev** un fichier vide nommé `debug.txt`. Le logger du moteur écrit alors `port.log` lors du prochain lancement.
5. Relancer la version Dev et déclencher une sauvegarde de test ; lire `port.log`.
6. Rechercher `save loaded but not writable`, `save write failed`, `save unavailable`, `save set aside`, `errno=`. Diffuser uniquement les lignes d'erreur expurgées, jamais les fichiers de sauvegarde.

**Hypothèses, pas diagnostics conclusifs** : le fichier Dev importé peut être possédé par un UID différent, son format peut être refusé ou son dossier peut être non inscriptible. Le mécanisme `SetSaveAside` conserve les images non reconnues sous `.sav.not-emerald*` ; ne pas les supprimer.

## Qualification avant prochaine version installable

- [ ] CI GitHub complète PASS sur cette branche, sans assouplir les tests.
- [ ] Compilation Android locale depuis cette branche ; `apksigner verify` PASS et package `com.cer0.emerald.dev`.
- [ ] Démarrage sur AYN Thor, retour du compteur de villes et vérification du mode classique.
- [ ] Pendant un combat, ZL réduit 4× à 3× puis 2×, ZR augmente ; dans le terrain, ZL/ZR restent indépendants.
- [ ] Comprendre le journal SAVE et corriger sa cause ; première sauvegarde puis reprise PASS.
- [ ] Vérifier la non-régression jour/nuit, les deux écrans et les commandes.
