---
title: Selfhosting
---

![Έκδοση επιτραπέζιας κυκλοφορίας](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Σταθερό&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fπεταλούδα%2Fσταθερή%2Fεφαρμογή%2Fpubspec. aml&style=for-the-badge)
![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

Είναι πολύ εύκολο να φιλοξενήσει το δικό σας διακομιστή web πεταλούδα.

## Απλός διακομιστής

Εγκαταστήστε το flutter και δημιουργήστε την εφαρμογή χρησιμοποιώντας:

```bash
cd app
flutter pub get
flutter build web
```

Όλα τα αρχεία βρίσκονται στον κατάλογο `app/build/web`.

## Προσάρτηση

Κλωνοποιήστε το αποθετήριο και χτίστε το `Dockerfile` χρησιμοποιώντας: `docker build -t linwood-butterfly`.
Ξεκινήστε το διακομιστή χρησιμοποιώντας: `docker τρέχει -p 8080:8080 -d linwood-butterfly`.
