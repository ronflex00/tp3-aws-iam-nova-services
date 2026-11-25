# Nettoyage final AWS

Nettoyage exécuté après inventaire préalable du compte. Les noms ont été lus
depuis `.secrets/lab.env`, comparés aux noms fixes du TP et au compte de la
session `tp-admin`. Le bucket suivait le motif Nova IAM du compte et se trouvait
dans `eu-north-1`.

## Résultat des suppressions

- Clé d'accès : une clé active recensée ; désactivée, puis supprimée. Le nombre
  de clés restant sur l'utilisateur est tombé à zéro avant suppression de
  l'utilisateur. Aucun identifiant de clé n'a été affiché.
- `TPReadDocuments` détachée de `TPReadDocumentsRole`, puis rôle supprimé.
- `TPAssumeReadRole` (et `TPDenyRead` si présent) supprimée de l'utilisateur.
- Aucun groupe IAM et aucune policy gérée externe trouvés sur `tp-iamuser`.
- `tp-iamuser` supprimé et vérifié absent par lecture directe et liste IAM.
- `TPReadDocuments` vérifiée sans attachements, supprimée et vérifiée absente.
- Bucket policy absente lors de l'inventaire ; suppression non requise.
- Bucket vérifié dans la région du TP, Block Public Access activé, Object
  Ownership `BucketOwnerEnforced`. Un seul objet logique, `document.txt`, était
  présent. Une version d'objet a aussi été découverte ; elle a été supprimée
  explicitement. Versions, marqueurs et objets ont ensuite été vérifiés absents.
- Bucket supprimé et vérifié absent de la liste des buckets.
- Aucune ressource `/managed/` n'a été modifiée.

## Vérification finale

`tp-iamuser`, `TPReadDocumentsRole`, la policy locale `TPReadDocuments` et le
bucket du laboratoire sont absents. La session `tp-admin` était encore une
session temporaire valide au moment de cette vérification. La commande
`aws logout --profile tp-admin` a ensuite terminé cette session locale ; le
dossier `.secrets/` propre au projet a été supprimé. Aucun fichier sous
`~/.aws` n'a été touché.

