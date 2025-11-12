---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Ενέργειες

|          Ποντίκι          |       Άγγιγμα       |         Ενέργεια         |
| :-----------------------: | :-----------------: | :----------------------: |
| Αριστερό κλικ και σύρσιμο |  Πατήστε και σύρετε | Δημιουργία νέας περιοχής |
|        Μεσαίο κλικ        |     Δύο δάχτυλα     |     Μετακίνηση καμβά     |
|         Δεξί κλικ         | Παρατεταμένο πάτημα |   Επεξεργασία περιοχής   |

## Διαμόρφωση

|            Ιδιότητα | Προεπιλογή | Περιγραφή                                                                                                                                                                                                                                                                                                                                                                                                              |
| ------------------: | :--------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|               Width |     `0`    | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|                Ύψος |     `0`    | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| Αναλογία διαστάσεων |     `0`    | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Υπάρχουν προεπιλογές αναλογίας τριών διαστάσεων:

- Τετράγωνο (1:1)
- Πορτρέτο σελίδας (sqrt(2)) - Αυτή είναι η προεπιλεγμένη αναλογία διαστάσεων μιας σελίδας Α4 σε λειτουργία πορτρέτου.
- Τοπίο σελίδας (1/sqrt(2)) - Αυτή είναι η προεπιλεγμένη αναλογία διαστάσεων μιας σελίδας Α4 σε οριζόντια λειτουργία.
