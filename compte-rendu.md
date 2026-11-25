# TP3 — AWS IAM : sécuriser les accès à un bucket S3

## Contexte

Laboratoire Nova Services sur un compte AWS du plan Free. La région du projet
est `eu-north-1`. L'utilisateur a confirmé la connexion humaine AWS Builder ID
avec MFA TOTP. Les opérations CLI de ce compte ont été exécutées avec une
session `tp-admin` temporaire.

## Environnement et sécurité du compte

AWS CLI utilisé : 2.37.9. Le compte AWS a été confirmé par STS ; son identifiant
n'est volontairement pas recopié dans ce rapport. Aucun compte root,
administrateur IAM, accès public, groupe IAM ou login console technique n'a été
créé pour ce TP.

## Architecture

Voir [docs/architecture.md](docs/architecture.md). L'identité humaine gère les
ressources ; `tp-iamuser` assume `TPReadDocumentsRole` pour lire le bucket.

## Bucket S3

Bucket general purpose dans `eu-north-1`, Object Ownership `BucketOwnerEnforced`,
ACL désactivées, Block Public Access activé sur ses quatre options, versioning
suspendu et chiffrement SSE-S3/AES256. `document.txt` a été téléversé et listé.
Le nom du bucket reste dans `.secrets/lab.env`.

## Identité technique et refus implicite

`tp-iamuser` a été créé sans groupe, login console ni permission initiale.
`GetCallerIdentity` a confirmé le profil technique. Sans autorisation S3,
`ListObjects` et `GetObject` ont été refusés.

## Identity-based policy

La customer managed policy `TPReadDocuments` autorise uniquement `s3:ListBucket`
sur le bucket du TP et `s3:GetObject` sur ses objets. Après attachement à
`tp-iamuser`, la liste et la lecture ont réussi ; `PutObject` a été refusé.
Après détachement, `GetObject` a été refusé une fois la propagation IAM stabilisée.

## Resource-based policy et Deny explicite

La bucket policy nomme `tp-iamuser` comme Principal et autorise la liste et la
lecture. Les deux ont réussi et le dépôt est resté refusé. Une policy inline
`TPDenyRead` a ensuite refusé `GetObject` malgré l'Allow de la bucket policy.
Lors du test initial, `ListObjects` avait aussi été refusé. La relecture des
fichiers confirme toutefois que la bucket policy autorise `s3:ListBucket` et
que le Deny ne vise que `s3:GetObject`. Un retest distinct après attente de
propagation a obtenu `ListObjects = ALLOW` et `GetObject = DENY`. La cause
exacte du résultat initial demeure inconnue faute de trace détaillée. Les
policies temporaires ont ensuite été retirées.

## AssumeRole / STS

La trust policy du rôle autorise le principal user du compte sous condition
`aws:PrincipalArn`. Avant d'ajouter la permission utilisateur
`TPAssumeReadRole`, `AssumeRole` a été refusé. Après autorisation et configuration
du profil `tp-role`, l'ARN STS a correspondu à
`assumed-role/TPReadDocumentsRole/nova-iam-lab`.

En phase finale, l'accès direct `tp-user` à la liste et à la lecture a été
refusé. La session `tp-role` a réussi la liste et la lecture ; `PutObject` a
été refusé.

## Matrice des tests

Voir [docs/tests.md](docs/tests.md). Les résultats marqués partiels ne sont pas
présentés comme des démonstrations complètes.

Les règles de l'expérience AWS Free listent S3 parmi les services accessibles
(hors S3 Access Grants) ; aucune restriction Free plan expliquant ces deux
résultats divergents n'a été identifiée. Voir les références AWS dans
`docs/tests.md`.

## Questions

Voir [docs/questions.md](docs/questions.md), comprenant les mini-exercices, les
dix questions et une policy de lecture mono-objet non appliquée.

## Nettoyage

**PENDING — confirmation requise.** Aucune suppression de ressource AWS n'a été
effectuée. Le bucket, l'utilisateur, la policy gérée, le rôle, les policies
inline et l'Access Key du laboratoire restent à nettoyer après validation.

## Conclusion

Les tests ont démontré l'accès minimal par policy d'identité et par rôle, et
l'interdiction d'écriture. Le retest a validé `ListObjects = ALLOW` avec
`GetObject = DENY`. L'anomalie de la première exécution reste sans cause
historique vérifiable ; son statut est donc PARTIAL pour l'analyse de cause,
malgré le retest fonctionnel concluant.
