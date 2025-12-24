---
title: Αποθήκευση
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Κατάλογος δεδομένων

Ο κατάλογος δεδομένων είναι ο κατάλογος όπου αποθηκεύονται έγγραφα, πρότυπα και πακέτα.
Στην επιφάνεια εργασίας μπορείτε να το βρείτε στο `~/Documents/Linwood/Butterfly`.
Στο κινητό είναι σε `getExternalFilesDir(null)/Linwood/Butterfly`.
Μπορείτε επίσης να το αλλάξετε στις ρυθμίσεις στην ενότητα `Data`.

Σε αυτόν τον κατάλογο θα βρείτε έναν φάκελο `Documents`, `Templates` και `Packs`.

## Ιστός

Τα δεδομένα εφαρμογής αποθηκεύονται στον περιηγητή σας. Αποθηκεύεται σε τοπικό χώρο αποθήκευσης.
Ανοίξτε τα εργαλεία προγραμματιστή στο πρόγραμμα περιήγησης και θα δείτε τα δεδομένα.

## Εγχώριες πλατφόρμες

Ως προεπιλογή, η εφαρμογή αποθηκεύει τα δεδομένα στο φάκελο εγγράφων σας σε έναν υποφάκελο που ονομάζεται "Linwood/Butterfly". Αυτός ο φάκελος δημιουργείται όταν αποθηκεύετε τα πρώτα δεδομένα. Αυτός ο φάκελος μπορεί να αλλάξει στις ρυθμίσεις.

## Απομακρυσμένη αποθήκευση {#remote}

:::note

Αυτή η λειτουργία δεν είναι διαθέσιμη στο διαδίκτυο.

:::

Η εφαρμογή μπορεί να αποθηκευτεί σε έναν απομακρυσμένο διακομιστή. Αυτό είναι χρήσιμο αν θέλετε να μοιραστείτε τα δεδομένα με άλλα άτομα ή αν έχετε πολλαπλούς υπολογιστές. Προς το παρόν υποστηρίζεται μόνο το πρωτόκολλο `WebDAV`.

Για να προσθέσετε έναν απομακρυσμένο διακομιστή, μεταβείτε στις ρυθμίσεις και κάντε κλικ στο κουμπί `Remotes`. Στη συνέχεια, κάντε κλικ στο `Add remote`.
Προσθέστε τη διεύθυνση URL του απομακρυσμένου διακομιστή και το όνομα χρήστη και τον κωδικό πρόσβασης. Μετά από αυτό μπορείτε να καθορίσετε το φάκελο όπου αποθηκεύονται τα δεδομένα.

Για να πάρετε το webdav url, επισκεφθείτε την τεκμηρίωση:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (θα πρέπει να μοιάζει κάπως έτσι: `https://nextcloud.example.com/remote.php/dav/files/username/`, αντικαταστήστε το `username` και το `nextcloud.example.com` με τις σωστές τιμές)

### Συγχρονισμός εκτός σύνδεσης {#offline}

Αυτή η δυνατότητα σας επιτρέπει να επεξεργαστείτε τα αρχεία σας σε απομακρυσμένους διακομιστές ενώ είστε εκτός σύνδεσης.
Ανοίξτε το αναδυόμενο μενού σε ένα αρχείο ή φάκελο και κάντε κλικ στο «Συγχρονισμός». Αυτό θα κατεβάσει το αρχείο ή το φάκελο και θα το αποθηκεύσει τοπικά. Για να συγχρονίσετε ολόκληρο το ριζικό κατάλογο, κάντε κλικ στο σημάδι ελέγχου στο διάλογο δημιουργίας ή κάντε κλικ στο απομακρυσμένο στη ρύθμιση και κάντε κλικ στο σημάδι ελέγχου στην ενότητα διαχείριση.

Υπάρχουν μερικοί περιορισμοί:

- Μπορείτε να συγχρονίσετε μόνο το ανώτερο επίπεδο ενός καταλόγου. Για παράδειγμα, αν έχετε έναν κατάλογο `a/b/test.bfly`, αυτό το αρχείο δεν θα συγχρονιστεί.
- Δεν μπορείτε να διαγράψετε ένα αρχείο ή φάκελο όσο είστε εκτός σύνδεσης.
- Δεν μπορείτε να προσθέσετε, να επεξεργαστείτε ή να διαγράψετε πρότυπα όσο είστε εκτός σύνδεσης.

## Άλλες μέθοδοι αποθήκευσης

Εάν είστε σε μια εγγενή συσκευή, μπορείτε επίσης να συγχρονίσετε τον κατάλογο εφαρμογών με την αγαπημένη σας πλατφόρμα.
Το Google drive έχει [μια επίσημη εφαρμογή](https://www.google.com/drive/download/) στα παράθυρα και υπάρχουν ανεπίσημες μονάδες στο κατάστημα παιχνιδιού.
Στο linux μπορείτε επίσης να χρησιμοποιήσετε το εγγενές σύστημα απομακρυσμένης αποθήκευσης και να αλλάξετε τον κατάλογο δεδομένων σας σε αυτόν ή να προσθέσετε ένα νέο εξωτερικό χώρο αποθήκευσης αν κάνετε κλικ στο κουμπί προσθήκη.

## Supported file types

Butterfly supports importing SVG, Butterfly Note (.bfly), Butterfly Raw Note (.tbfly).

### Butterfly Note (.bfly)

This file type is the recommended for saving notes.

It is a zip archive containing the information (mostly in JSON files) about the note.
These included JSON files aren't optimized for being human readable.

### Butterfly Raw Note (.tbfly)

This file is recommended for use with version control software like git.

This file is **not** a zip archive, instead it is a _JSON_ file.
It contains all the information about the note in a single JSON file that is optimized for being readable and nicely formatted. It is **slower** than the normal Butterfly Note in loading speed.

### SVG

This file type doesn't save information about the note!
When this file is imported into Butterfly, it is treated as a single image.

Use this _ONLY_ when the note shouldn't be modified by butterfly.
