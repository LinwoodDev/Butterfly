---
sidebar_label: Συνεργασία
sidebar_position: 4
title: Συνεργασία
---

:::warning 🧪 Πείραμα

Αυτή η λειτουργία βρίσκεται πίσω από μια σημαία πειράματος. Διαβάστε περισσότερα [here](/nightly#experiments).
Όλα σε αυτή την ενότητα υπόκεινται σε αλλαγή.

:::

## Εισαγωγή

Η έκδοση beta 2.0, Butterfly υποστηρίζει συνεργασία. Αυτό σημαίνει ότι μπορείτε να επεξεργαστείτε το ίδιο αρχείο με πολλά άτομα ταυτόχρονα. Αυτό είναι χρήσιμο αν θέλετε να εργαστείτε μαζί σε ένα έγγραφο.

## Πώς λειτουργεί

Το Butterfly χρησιμοποιεί έναν διακομιστή websocket που θα φιλοξενηθεί στον υπολογιστή σας. Αυτός ο διακομιστής πρέπει να είναι προσβάσιμος από το διαδίκτυο ή το τοπικό σας δίκτυο. Ο πελάτης θα συνδεθεί σε αυτόν τον διακομιστή. Ο διακομιστής συγχρονίζει όλες τις αλλαγές και τα γεγονότα με όλους τους πελάτες.

## Ρύθμιση του διακομιστή

:::note

Αυτή η λειτουργία του διακομιστή δεν είναι διαθέσιμη στο διαδίκτυο.

:::

Πρώτον, ενεργοποιήστε το πείραμα συνεργασίας στις ρυθμίσεις. Μετά από αυτό ανοίξτε το έγγραφό σας που θέλετε να μοιραστείτε. Στη συνέχεια, κάντε κλικ στο κουμπί κοινοποίησης στην επάνω αριστερή γωνία δεξιά προς τον τίτλο. Αυτό θα ανοίξει ένα διάλογο. Κάντε κλικ στο `Start server`.

Προεπιλεγμένα ο διακομιστής θα φιλοξενείται σε όλες τις διεπαφές στη θύρα `28005`. Μπορείτε να το αλλάξετε στο διάλογο. Πρέπει να βεβαιωθείτε ότι αυτός ο διακομιστής είναι προσβάσιμος στον υπολογιστή-πελάτη.
Στο τοπικό δίκτυο αυτό θα πρέπει να λειτουργήσει έξω από το κουτί. Αν θέλετε να αποκτήσετε πρόσβαση στο διακομιστή από το διαδίκτυο, θα πρέπει να προωθήσετε τη θύρα στον δρομολογητή σας. Μπορείτε να βρείτε περισσότερες πληροφορίες σχετικά με αυτό το [here](https://en.wikipedia.org/wiki/Port_forwarding/).

Αν δεν μπορείτε να προωθήσετε την θύρα, μπορείτε να χρησιμοποιήσετε μια υπηρεσία όπως [ngrok](https://ngrok.com/). Αυτό θα δημιουργήσει μια διοχέτευση στον τοπικό σας διακομιστή. Αυτό είναι χρήσιμο αν θέλετε να μοιραστείτε το έγγραφο με άλλους ανθρώπους.

For ngrok the command would look like this:

```bash
ngrok http 28005
```

## Σύνδεση στο διακομιστή

Τώρα πρέπει να συνδεθείτε στο διακομιστή. Για να το κάνετε αυτό, μεταβείτε στην αρχική σελίδα και κάντε κλικ στο κουμπί συν όπως θα δημιουργήσετε ένα νέο έγγραφο. Εκεί θα δείτε ένα νέο στοιχείο μενού που ονομάζεται `Connect`.

Κάντε κλικ σε αυτό και θα δείτε ένα διάλογο. Εισάγετε εδώ το url σύνδεσης.
Εάν βρίσκεστε στο ίδιο δίκτυο, μπορείτε να χρησιμοποιήσετε την τοπική διεύθυνση ip του υπολογιστή όπου εκτελείται ο διακομιστής.
Το url θα πρέπει να μοιάζει κάπως έτσι: `w://{ip}:28005`. Αντικαταστήστε `{ip}` με τη διεύθυνση ip του υπολογιστή. Μπορείτε να βρείτε τη διεύθυνση ip με την εντολή `ipconfig` στα παράθυρα ή `ifconfig` στο linux. Στο Android μπορείτε να βρείτε τη διεύθυνση ip στις ρυθμίσεις wifi.

Εάν δεν είστε στο ίδιο δίκτυο, πρέπει να χρησιμοποιήσετε τη δημόσια διεύθυνση ip του υπολογιστή. Μπορείτε να το βρείτε αναζητώντας το `τι είναι το δικό μου ip` στο αγαπημένο σας πρόγραμμα περιήγησης αναζήτησης. Το url θα πρέπει να μοιάζει με το παραπάνω αλλά με το δημόσιο ip διεύθυνση.

Αν χρησιμοποιείτε το ngrok, η ρύθμιση είναι λίγο διαφορετική. Αντικαταστήστε το `Ş` με το `wss` και προσθέστε τη θύρα `:28005` στο τέλος. Το url θα πρέπει να μοιάζει κάπως έτσι: `wss://{random}:28005`. Αντικαταστήστε το τυχαίο μέρος με το μέρος που σας δίνει.
