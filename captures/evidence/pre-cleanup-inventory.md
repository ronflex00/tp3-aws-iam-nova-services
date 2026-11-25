# Inventaire avant nettoyage

Relevé obtenu par appels AWS en lecture seule, avant toute suppression.

- Région du laboratoire : `eu-north-1`.
- `tp-admin` : identité valide dans le compte correspondant au préfixe du
  bucket localement enregistré.
- Bucket du laboratoire : nom tiré de `.secrets/lab.env`, motif
  `nova-iam-<compte>-<suffixe hexadécimal>` ; région vérifiée `eu-north-1`.
- Objet observé : `document.txt`.
- Block Public Access : les quatre options activées.
- Object Ownership : `BucketOwnerEnforced`.
- Clé d'accès de `tp-iamuser` : une, active. Son identifiant n'a pas été
  affiché ni enregistré.
- `tp-iamuser` : aucune policy gérée attachée, inline `TPAssumeReadRole`, aucun
  groupe.
- `TPReadDocumentsRole` : policy gérée `TPReadDocuments` attachée, aucune
  policy inline.
- `TPReadDocuments` : attachée uniquement à `TPReadDocumentsRole`.
- Bucket policy : absente avant nettoyage.

Les noms exacts et l'identifiant du compte ont été chargés depuis la
configuration locale pendant l'inventaire ; le dossier local `.secrets/` a
depuis été supprimé après clôture de la session. Ce relevé ne contient aucun
credential, token STS, Access Key ID, Secret Access Key ou Account ID.

