# Matrice des tests observés

`ALLOW` et `DENY` reflètent des appels AWS réellement exécutés. Le scénario
bucket policy + Deny a été rejoué séparément après 30 secondes de propagation.

| Configuration | ListObjects | GetObject | PutObject | Statut |
|---|---|---|---|---|
| tp-user sans autorisation | DENY | DENY | Non exécuté | Observé |
| Managed policy attachée | ALLOW | ALLOW | DENY | PASS |
| Managed policy détachée | Non retesté | DENY après propagation | Non exécuté | Partiel |
| Bucket policy | ALLOW | ALLOW | DENY | PASS |
| Bucket policy + TPDenyRead | ALLOW au retest | DENY au retest | Non exécuté | PASS retest |
| tp-user avec seulement TPAssumeReadRole | DENY direct | DENY direct | Non exécuté | Partiel |
| Session tp-role | ALLOW | ALLOW | DENY | PASS |

Le test d'écriture utilise `interdit.txt` ou une clé de test propre au rôle.
Les appels `GetObject` qui réussissent ont écrit dans `downloads/` ; aucun
fichier local antérieur n'a servi de preuve.

## Détail Deny explicite et diagnostic

Relecture des JSON : `bucket-read.json` contient un Allow explicite
`s3:ListBucket` pour le principal `arn:aws:iam::<compte-du-lab>:user/tp-iamuser`
sur l'ARN du bucket. `deny-read.json` contient uniquement `s3:GetObject`, avec
la ressource objet `bucket/*`. Les ARN, le principal et les noms de ressources
correspondent au laboratoire. Block Public Access était toujours activé.

Le retest a utilisé le profil `tp-user`, vérifié auparavant comme
`tp-iamuser`. Après application de la bucket policy, attente de propagation,
puis ajout de `TPDenyRead` et nouvelle attente, deux appels distincts ont donné :

- `ListObjects` : succès ;
- `GetObject document.txt` : refus.

Les policies temporaires ont été retirées après le test. La bucket policy est
absente et `TPDenyRead` est absente. Le profil `tp-role` a encore été vérifié
comme session `assumed-role/TPReadDocumentsRole/nova-iam-lab`.

Les traces de la première exécution ne contiennent pas la réponse AWS détaillée,
le moment exact de propagation, ni une preuve de l'identité appelée à cet
instant. La cause historique du premier `ListObjects: AccessDenied` reste donc
indéterminée. Une propagation incomplète ou un décalage d'état de policy est
plausible, mais non démontré. Le résultat initial reste enregistré ; le retest
réussit sans changer la policy ni élargir les permissions.

## Free plan

La documentation AWS de l'expérience Free liste Amazon S3 parmi les services
inclus, avec l'exception S3 Access Grants. Les restrictions Free plan visent
un sous-ensemble de services/offres, pas une règle documentée qui changerait
l'évaluation IAM entre `s3:ListBucket` et `s3:GetObject`. IAM/S3 ont accepté les
appels de ce laboratoire ; aucune restriction n'a été contournée.

Sources : [services pris en charge par la nouvelle expérience AWS](https://docs.aws.amazon.com/accounts/latest/reference/supported-services-sign-up-new.html),
[FAQ du Free plan](https://aws.amazon.com/free/free-tier-faqs/).

