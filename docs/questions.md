# Questions et mini-exercices

## Mini-exercices

- **Crédits AWS et Free plan :** le plan Free décrit l'offre du compte ; des
  crédits éventuels couvrent certains frais selon les conditions du compte et
  des services. Surveiller la facturation et limiter le laboratoire à ses
  ressources S3/IAM prévues.
- **MFA Builder ID et clé IAM :** le MFA protège la connexion humaine. Une
  access key authentifie l'identité technique `tp-iamuser` et ne remplace pas
  le MFA de la personne.
- **Pourquoi `get-caller-identity` d'abord :** confirmer quelle identité
  signe les appels avant d'évaluer ses autorisations.
- **Chiffrement et contrôle d'accès :** SSE-S3 protège les données au repos ;
  IAM et la bucket policy déterminent qui peut appeler les opérations S3.
- **Authentification et autorisation :** l'authentification établit l'identité ;
  l'autorisation décide si cette identité peut effectuer l'action demandée.
- **Limiter `GetObject` à un document :** utiliser une ressource objet exacte,
  par exemple `arn:aws:s3:::BUCKET/rapports/rapport.csv`.
- **Identity policy et bucket policy :** la première est attachée au principal ;
  la seconde à la ressource S3. Les deux participent à l'évaluation d'accès.
- **`Principal` :** désigne l'identité à laquelle une policy de ressource
  accorde ou refuse l'accès.
- **Block Public Access :** empêche les politiques et ACL publiques ; il reste
  actif car l'accès du TP est limité à un principal IAM nommé.
- **Allow et Deny explicite :** un Deny explicite prévaut sur un Allow applicable.
- **Trust policy et permissions policy :** la trust policy détermine qui peut
  assumer le rôle ; la policy de permissions détermine les actions permises
  après l'assumption.
- **Sessions STS :** elles fournissent des identifiants temporaires et limités
  dans le temps au lieu d'utiliser directement l'identité source pour S3.

## Dix questions du sujet

1. **Builder ID vs IAM user :** Builder ID sert à la connexion humaine ; IAM
   user est l'identité AWS technique utilisée par ce laboratoire.
2. **Pourquoi pas de groupes IAM :** l'exercice isole les permissions attachées
   directement à un user et compare ensuite l'accès par rôle.
3. **Free plan et consommation :** Free plan n'implique pas que chaque service
   ou usage soit toujours gratuit ; vérifier l'offre et l'activité de facturation
   du compte.
4. **Authentication vs authorization :** preuve d'identité vs décision d'accès.
5. **ARN `ListBucket` vs `GetObject` :** le premier cible le bucket
   `arn:aws:s3:::BUCKET`, le second les objets `arn:aws:s3:::BUCKET/*`.
6. **Bucket policy sans identity policy :** une bucket policy peut accorder
   directement un accès à un principal explicitement désigné ; un Deny applicable
   prévaut toujours.
7. **Allow + Explicit Deny :** le Deny explicite l'emporte sur l'Allow.
8. **Trois documents AssumeRole :** trust policy du rôle, policy de permissions
   S3 attachée au rôle et policy utilisateur autorisant `sts:AssumeRole`.
9. **Pourquoi pas `AmazonS3FullAccess` :** elle donnerait un périmètre bien plus
   large que `ListBucket` et `GetObject` sur le bucket du TP.
10. **Que nettoyer :** clé d'accès, policies attachées/inline, rôle,
    utilisateur, policy gérée, bucket policy, objets et bucket, puis cache de
    session/profil local dédié au TP.

## Policy illustrative non appliquée

Une application connaissant la clé exacte peut recevoir cette permission, sans
`s3:ListBucket` :

```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::BUCKET/rapports/rapport.csv"
  }]
}
```
