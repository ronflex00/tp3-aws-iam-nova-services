# Matrice des tests observés

`ALLOW` et `DENY` reflètent des appels AWS réellement exécutés. IAM peut
nécessiter un délai de propagation après une modification de policy ; les cas
marqués `À retester` ont produit des observations instables.

| Configuration | ListObjects | GetObject | PutObject | Statut |
|---|---|---|---|---|
| tp-user sans autorisation | DENY | DENY | Non exécuté | Observé |
| Managed policy attachée | ALLOW | ALLOW | DENY | PASS |
| Managed policy détachée | Non retesté | DENY après propagation | Non exécuté | Partiel |
| Bucket policy | ALLOW | ALLOW | DENY | PASS |
| Bucket policy + TPDenyRead | DENY observé, à retester | DENY | Non exécuté | Partiel |
| tp-user avec seulement TPAssumeReadRole | DENY direct | DENY direct | Non exécuté | Partiel |
| Session tp-role | ALLOW | ALLOW | DENY | PASS |

Le test d'écriture utilise `interdit.txt` ou une clé de test propre au rôle.
Les appels `GetObject` qui réussissent ont écrit dans `downloads/` ; aucun
fichier local antérieur n'a servi de preuve.

## Détail Deny explicite

Avec `TPDenyRead`, `GetObject` a renvoyé un refus alors qu'une bucket policy
Allow était présente. Lors du même essai, `ListObjects` a également été refusé,
contrairement au comportement attendu : cela indique une propagation ou un
état de policy à revérifier. Ne pas présenter ce test comme une démonstration
complète avant d'avoir obtenu `ListObjects = ALLOW` et `GetObject = DENY` dans
la même configuration.

