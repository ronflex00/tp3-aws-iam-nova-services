# Architecture du laboratoire

```mermaid
flowchart TD
    H[Builder ID + MFA] --> A[tp-admin, session temporaire]
    A --> I[IAM]
    A --> S[S3 privé]
    U[tp-iamuser] -->|accès direct final : refus| S
    U -->|sts:AssumeRole autorisé| R[TPReadDocumentsRole]
    R -->|ListBucket + GetObject| S
```

Région : `eu-north-1`. Le bucket utilise Block Public Access, Bucket owner
enforced et SSE-S3 AES256. Son nom et l'identifiant du compte sont conservés
uniquement dans `.secrets/lab.env` et ne sont pas répétés ici.
