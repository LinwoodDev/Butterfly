---
title: "Φτιάξτε το δικό σας"
sidebar_position: 1
---

1. Εγκαταστήστε το git και το flutter (beta)
2. Κλωνοποίηση του αποθετηρίου
3. Μεταβείτε στον κατάλογο εφαρμογών
4. Χρησιμοποιήστε το εργαλείο πτερυγισμού για να μεταγλωττίσετε την εφαρμογή
   * `κατασκευή πτερυγίου apk`
   * `flutter build πακέτο`
   * `flutter build web`
   * `flutter build linux`
   * `flutter κατασκευή παραθύρων`
   * `flutter build ios --release --no-codesign`\
     μετά από αυτό, δημιουργήστε ένα φάκελο που ονομάζεται "Payload", αντιγράψτε το Runner.app σε αυτό και zip το φάκελο ωφέλιμου φορτίου. Στη συνέχεια, μετονομάστε ".zip" σε ".ipa".
5. Τα μεταγλωττισμένα αρχεία βρίσκονται στον κατάλογο κατασκευής
