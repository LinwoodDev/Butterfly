---
title: Zusammenarbeit
---

:::caution[🧪 Experiment]

Dieses Feature befindet sich hinter einer experimentellen Flag. Mehr erfahren [here](/community/nightly#experiments).
Alles in diesem Abschnitt kann geändert werden.

:::

## Einführung

Seit der Betaversion 2.0 unterstützt Butterfly Zusammenarbeit. Dies bedeutet, dass Sie die gleiche Datei mit mehreren Personen gleichzeitig bearbeiten können. Dies ist nützlich, wenn Sie an einem Dokument zusammenarbeiten möchten.

## Swamp

Swamp ist ein Protokoll, mit dem du dein Dokument über einen Remote-Server mit anderen Personen teilen kannst. Das ist nützlich, wenn sich die andere Person nicht im selben Netzwerk befindet wie du. Der Server dient nur als Proxy für die Verbindung und kann die Daten nicht lesen, da alles Ende-zu-Ende verschlüsselt ist.

### Swamp einrichten

Erstelle einen Swamp-Server, indem du die [Swamp-Website](https://swamp.linwood.dev) besuchst.
Gib nun die URL des Servers in der Zusammenarbeitsansicht ein. Die URL sollte so aussehen: `wss://example.com` oder `ws://example.com`. Bitte beachte, dass im Web nur sichere Verbindungen erlaubt sind. Stelle außerdem sicher, dass der Server aus dem Internet erreichbar ist.

Nun kannst du einfach auf `Start` klicken, um den Server zu starten. Mit dem angegebenen Link kannst du das Dokument mit anderen Personen teilen. Sie können den Link einfach in den Verbindungsdialog eingeben und auf `Verbinden` klicken. Dadurch werden sie mit dem Server verbunden und können das Dokument bearbeiten.

## WebSocket

Butterfly verwendet einen WebSocket-Server, der auf deinem Computer gehostet wird. Dieser Server muss aus dem Internet oder deinem lokalen Netzwerk erreichbar sein. Der Client verbindet sich mit diesem Server. Der Server synchronisiert alle Änderungen und Ereignisse mit allen Clients.

### Server einrichten

:::note

Diese Serverfunktion ist im Web nicht verfügbar.

:::

Aktiviere zuerst das Zusammenarbeitsexperiment in den Einstellungen. Öffne danach das Dokument, das du teilen möchtest. Klicke dann oben links rechts neben dem Titel auf die Teilen-Schaltfläche. Dadurch wird ein Dialog geöffnet. Klicke auf `Server starten`.

Standardmäßig wird der Server auf allen Schnittstellen über Port `28005` gehostet. Du kannst dies im Dialog ändern. Du musst sicherstellen, dass dieser Server für den Client erreichbar ist.
Im lokalen Netzwerk sollte dies ohne weitere Einrichtung funktionieren. Wenn du vom Internet aus auf den Server zugreifen möchtest, musst du den Port in deinem Router weiterleiten. Weitere Informationen dazu findest du [hier](https://de.wikipedia.org/wiki/Portweiterleitung).

Wenn du den Port nicht weiterleiten kannst, kannst du einen Dienst wie [ngrok](https://ngrok.com/) verwenden. Dadurch wird ein Tunnel zu deinem lokalen Server erstellt. Das ist nützlich, wenn du das Dokument mit anderen Personen teilen möchtest.

Für ngrok würde der Befehl so aussehen:

```bash
ngrok http 28005
```

### Mit dem Server verbinden

Nun musst du dich mit dem Server verbinden. Gehe dazu zur Startseite und klicke auf die Plus-Schaltfläche, als würdest du ein neues Dokument erstellen. Dort siehst du einen neuen Menüpunkt namens `Verbinden`.

Klicke darauf, dann wird ein Dialog angezeigt. Gib hier die Verbindungs-URL ein.
Wenn du dich im selben Netzwerk befindest, kannst du die lokale IP-Adresse des Computers verwenden, auf dem der Server läuft.
Die URL sollte so aussehen: `ws://{ip}:28005`. Ersetze `{ip}` durch die IP-Adresse des Computers. Du findest die IP-Adresse unter Windows mit dem Befehl `ipconfig` oder unter Linux mit `ifconfig`. Unter Android findest du die IP-Adresse in den WLAN-Einstellungen.

Wenn du dich nicht im selben Netzwerk befindest, musst du die öffentliche IP-Adresse des Computers verwenden. Du findest sie, indem du in deiner bevorzugten Suchmaschine nach `what is my IP` suchst. Die URL sollte wie oben aussehen, aber mit der öffentlichen IP-Adresse.

Wenn du ngrok verwendest, ist die Einrichtung etwas anders. Ersetze `https` durch `wss` und füge am Ende den Port `:28005` hinzu. Die URL sollte so aussehen: `wss://{random}:28005`. Ersetze den zufälligen Teil durch den Teil, den ngrok dir gibt.
