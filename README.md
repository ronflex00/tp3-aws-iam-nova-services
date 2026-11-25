# TP3 — AWS IAM : sécuriser les accès à un bucket S3

Laboratoire Nova Services. Les résultats AWS seront ajoutés uniquement après
exécution réelle des étapes du sujet. Aucun secret, identifiant de clé ou
jeton ne doit être ajouté à ce dépôt.

## Préparation

Fish :

```fish
source scripts/use-lab-env.fish
./scripts/check-env.sh
```

Bash :

```bash
source scripts/use-lab-env.sh
./scripts/check-env.sh
```

Le laboratoire a été réalisé avec AWS CLI v2, après création humaine du compte,
activation MFA et création manuelle de l'unique Access Key technique.

## État final

Les tests IAM/S3/STS ont été réalisés et les ressources AWS du laboratoire ont
été supprimées. La cause du premier refus inattendu de `ListObjects` n'a pas pu
être établie ; un retest ultérieur du scénario Deny explicite a donné le résultat
attendu. Voir `compte-rendu.md` et `docs/cleanup.md`.

