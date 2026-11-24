# Synchronisation upstream — Emerald Extended

## Références contrôlées le 24 novembre 2026

| Dépôt | Rôle | Référence observée |
| --- | --- | --- |
| [Cer0-D/emerald-android](https://github.com/Cer0-D/emerald-android) | Parent direct, port Android, référence d'intégration prioritaire | main ba8ca2671255d5b96c13d2b817e1721517299f90 ; release android-v0.5.0.3 (15/11/2026) |
| [ZallaxDev/emerald-3ds](https://github.com/ZallaxDev/emerald-3ds) | Projet d'origine, moteur partagé et voxel | main bcae4b70dac61419fc933084084469f6cfbe344b ; release v0.5.0 (30/10/2026) |
| ZallaxDev/emerald-3ds dev et integration | Préversions et développements en cours, pas une base stable | dev et integration 6de1c53dfa20a9f4c2d381bfc2c827775ac8eb6d |
| Proginji2000/emerald-android | Fork de développement | main : documentation locale au-dessus de ba8ca267 ; PR #6/#7 : travail à qualifier |

Les SHA 3DS sont des **références observées**, pas une affirmation que tous ces commits sont déjà intégrés dans le port Android. Relever de nouveau les refs avant chaque opération.

## Politique de maintenance

1. Surveiller main, tags/releases de chaque upstream ; suivre dev/integration de 3DS séparément comme veille, sans intégration automatique.
2. Comparer les SHA au dernier état observé. Examiner commits, notes de version, modifications par fichier et dépendances. Classer : correctif utile, nouvelle fonctionnalité, régression, changement d'ABI/recette/localisation, licence.
3. Privilégier la mise à jour Android de Cer0-D lorsqu'elle porte déjà les changements de 3DS. Si un correctif 3DS pertinent n'est pas encore porté, étudier un backport ciblé (avec attribution et revue de compatibilité) dans une branche spécifique. Ne jamais fusionner aveuglément tout le repo 3DS dans le port Android.
4. Préparer une branche de qualification à partir de la dernière base de développement validée, conserver les refs d'origine, ouvrir une PR brouillon distincte par lot cohérent. Utiliser merge/rebase/cherry-pick selon la relation réelle des historiques ; pas de force-push sur une branche partagée ni de merge automatique sur main.
5. Rejouer les changements Emerald Extended ; vérifier les conflits et les fonctionnalités remplacées par l'upstream, sans les développer deux fois.
6. Qualifier et documenter : CI complète, audit strict, manifestes FR, ABI/recettes, build APK local Dev, tests sur Thor (sauvegarde/import, carte, vitesse, jour/nuit, voxel, progression), rollback. Garder la ROM et les sauvegardes hors dépôt.
7. Promouvoir uniquement après revue et critères PASS ; actualiser README, roadmap, passation et backlog. En cas de FAIL, conserver le dernier état validé, documenter le blocage et corriger sur la branche de qualification.

## Références Git locales

Dans un clone de travail (commandes proposées, non exécutées sur le PC utilisateur) :

```bash
git remote -v
# Ajouter si absent ; vérifier l'URL si le nom existe déjà :
git remote add upstream-android https://github.com/Cer0-D/emerald-android.git
git remote add upstream-3ds https://github.com/ZallaxDev/emerald-3ds.git
git fetch upstream-android --no-tags
git fetch upstream-3ds --no-tags
git log --oneline --left-right HEAD...upstream-android/main
```

Vérifier les releases par dépôt sur GitHub pour éviter les collisions de noms de tags. Le fetch seul ne modifie ni l'arbre de travail ni les commits locaux. Ne pas lancer de merge avant analyse du delta. Les nouvelles fonctions upstream sont des candidates à la revue de réutilisation ; garder la licence et la provenance de chaque changement.

## Suivi

EE-003 dans [le backlog](EMERALD_EXTENDED_BACKLOG.md) reste un chantier récurrent. Une notification d'évolution doit fournir dépôt/ref, ancien et nouveau SHA, lien, résumé, impact et action proposée. Une notification ne constitue pas une mise à jour intégrée. Les mises à jour de préversion 3DS peuvent être nombreuses : regrouper les changements pertinents, pas de notification pour des pushes sans intérêt pour le fork.

**STOP** : incompatibilité de sauvegarde non résolue, changement de format ou de données non qualifié, audit FAIL, CI FAIL, signature/package incorrect, risque d'écraser l'app officielle. Aucune ROM, sauvegarde ou APK privé dans GitHub.
