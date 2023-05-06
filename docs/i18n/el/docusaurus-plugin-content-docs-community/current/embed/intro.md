---
title: Ενσωμάτωση
sidebar_label: Εισαγωγή
---

Η ενσωμάτωση είναι ένας απλός τρόπος για να συμπεριλάβετε την εφαρμογή στην ιστοσελίδα σας. Προσθέστε τον ακόλουθο κώδικα στην ιστοσελίδα σας:

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Επιλογές

| Επιλογή  | Τύπος                                | Προεπιλογή | Περιγραφή                                                                                                                                            |
| -------- | ------------------------------------ | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| save     | Boolean (true, false)                | true       | Ενεργοποίηση αποθήκευσης. Αν απενεργοποιηθεί, θα εμφανιστεί μόνο ένα κουμπί εξόδου                                                                   |
| editable | Boolean (true, false)                | true       | Ενεργοποίηση επεξεργασίας. Εάν απενεργοποιηθεί, το έγγραφο θα είναι μόνο για ανάγνωση                                                                |
| language | Συμβολοσειρά (..., σύστημα, χρήστης) | system     | Γλώσσα του εγγράφου. Εάν το σύστημα, η γλώσσα θα εντοπιστεί από το πρόγραμμα περιήγησης. Εάν ο χρήστης, η γλώσσα θα ορίσει την προτίμηση των χρηστών |

## Συμβάντα

Παραδείγματα πώς να το χρησιμοποιήσετε:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type == = 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### save

> Το γεγονός `αποθήκευση` εκπέμπεται όταν ο χρήστης κάνει κλικ στο κουμπί αποθήκευσης.

Παράμετροι:

* `data` (Type `List<int>`): The data of the document.

### exit

> Το συμβάν `εξόδου` εκπέμπεται όταν ο χρήστης κάνει κλικ στο κουμπί εξόδου.

Παράμετροι:

* `data` (Type `List<int>`): The data of the document.

### change

> Το συμβάν `αλλαγής` εκπέμπεται όταν ο χρήστης αλλάξει το έγγραφο.

Παράμετροι:

* `data` (Type `List<int>`): The data of the document.

## Μέθοδοι

Παράδειγμα πώς να το χρησιμοποιήσετε:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.pushMessage('getData', {});
embedElement.addEventListener('message', (data) => {
  if(data.detail.type == 'getData') }
    console.log(data.detail.message);
  }
});
```

### getData

> Η μέθοδος `getData` επιστρέφει τα δεδομένα του εγγράφου.

Δεν υπάρχουν παράμετροι. Returns: `List<int>`

### setData

> Η μέθοδος `setData` ορίζει τα δεδομένα του εγγράφου.

Παράμετροι:

* `data` (Type `List<int>`): The data of the document.

### render

> Η μέθοδος `απόδοσης` καθιστά το έγγραφο σε μια εικόνα png.

Παράμετροι:

* `width` (Type `Number`): Το πλάτος της εικόνας.
* `ύψος` (Τύπος `αριθμός`): Το ύψος της εικόνας.
* `κλίμακα` (Τύπος `αριθμός`): Η κλίμακα της εικόνας.
* `renderBackground` (Πληκτρολογήστε `Boolean`): Αν είναι αληθές, το φόντο θα εμφανιστεί.

Επιστρέφει: `String` (Base64 κωδικοποιημένη εικόνα)

### renderSVG

> Η μέθοδος `renderSVG` αποδίδει το έγγραφο σε εικόνα svg

Παράμετροι:

* `width` (Type `Number`): Το πλάτος της εικόνας.
* `ύψος` (Τύπος `αριθμός`): Το ύψος της εικόνας.
* `renderBackground` (Πληκτρολογήστε `Boolean`): Αν είναι αληθές, το φόντο θα εμφανιστεί.

Επιστροφές: `Συμβολοσειρά` (SVG)
