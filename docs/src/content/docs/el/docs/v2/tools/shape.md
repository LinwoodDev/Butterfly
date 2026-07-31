---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Διαμόρφωση

|             Ιδιότητα |                  Προεπιλογή                  | Περιγραφή                                                                                                                                                                                                       |
| -------------------: | :------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|               Κέντρο |                    ψευδές                    | Draws the shape from the center instead of from the corner.                                                                                                                                     |
|                Width |                       0                      | Το σταθερό πλάτος της περιοχής. Εάν οριστεί σε 0, το πλάτος θα υπολογιστεί αυτόματα.                                                                                            |
|                 Ύψος |                       0                      | Το σταθερό ύψος της περιοχής. Εάν οριστεί σε 0, το ύψος θα υπολογίζεται αυτόματα.                                                                                               |
|  Αναλογία διαστάσεων |                       0                      | Η καθορισμένη αναλογία διαστάσεων της περιοχής. Εάν οριστεί σε 0, η αναλογία διαστάσεων θα υπολογίζεται αυτόματα. An aspect ratio is defined as width / height. |
| Πλάτος περιγράμματος |                       5                      | Το πλάτος της διαδρομής                                                                                                                                                                                         |
|        Στυλ πινελιάς |                     Solid                    | The style of the stroke. Other styles can use dash and gap lengths.                                                                                                             |
|         Μήκος παύλας |                       1                      | The length of the dash when using a non-solid stroke style                                                                                                                                                      |
|          Μήκος κενού |                       1                      | The length of the gap when using a non-solid stroke style                                                                                                                                                       |
|                Χρώμα |    Solid Color (Black)    | [Customization](../../colors/#further-customization) for the color of the shape                                                                                                                                 |
|                Σχήμα |                   Ορθογώνιο                  | The shape that will be drawn. Available shapes are Rectangle, Triangle, Circle and Line                                                                                                         |
|        Corner radius |                  0, 0, 0, 0                  | The radius of the corners when shape is Rectangle                                                                                                                                                               |
|              Γέμισμα | Solid Color (Transparent) | [Customization](../../colors/#further-customization) for the color drawn inside the shape. Not available for Line shapes                                                                        |
|  Εξαρτώμενο από ζουμ |                    ψευδές                    | Αυτό θα αλλάξει το πλάτος της διαδρομής με βάση το επίπεδο εστίασης.                                                                                                                            |