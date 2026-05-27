---
title: Zusammenarbeit
---

:::caution[🧪 Experiment]

Dieses Feature befindet sich hinter einer experimentellen Flag. Mehr erfahren Sie [hier](/community/nightly#experiments).
Alles in diesem Abschnitt kann geändert werden.

:::

## Einführung

Seit der Betaversion 2.0 unterstützt Butterfly Zusammenarbeit. Dies bedeutet, dass Sie die gleiche Datei mit mehreren Personen gleichzeitig bearbeiten können. Dies ist nützlich, wenn Sie an einem Dokument zusammenarbeiten möchten.

## Swamp

Swamp ist ein Protokoll, mit dem Sie Ihr Dokument über einen Remote-Server mit anderen Personen teilen können. Das ist nützlich, wenn sich die andere Person nicht im selben Netzwerk befindet wie Sie. Der Server dient nur als Proxy für die Verbindung und kann die Daten nicht lesen, da alles Ende-zu-Ende verschlüsselt ist.

### Swamp einrichten

Erstellen Sie einen Swamp-Server, indem Sie die [Swamp-Website](https://swamp.linwood.dev) besuchst.
Gib nun die URL des Servers in der Zusammenarbeitsansicht ein. Die URL sollte so aussehen: `wss://example.com` oder `ws://example.com`. Bitte beachte, dass im Web nur sichere Verbindungen erlaubt sind. Stellen Sie außerdem sicher, dass der Server aus dem Internet erreichbar ist.

Nun können Sie einfach auf `Start` klicken, um den Server zu starten. Mit dem angegebenen Link können Sie das Dokument mit anderen Personen teilen. Sie können den Link einfach in den Verbindungsdialog eingeben und auf `Verbinden` klicken. Dadurch werden sie mit dem Server verbunden und können das Dokument bearbeiten.

## WebSocket

Butterfly verwendet einen WebSocket-Server, der auf Ihrem Computer gehostet wird. Dieser Server muss aus dem Internet oder Ihrem lokalen Netzwerk erreichbar sein. Der Client verbindet sich mit diesem Server. Der Server synchronisiert alle Änderungen und Ereignisse mit allen Clients.

### Server einrichten

:::note

Diese Serverfunktion ist im Web nicht verfügbar.

:::

Aktiviere zuerst das Zusammenarbeitsexperiment in den Einstellungen. Öffnen Sie danach das Dokument, das Sie teilen möchten. Klicken Sie dann oben links rechts neben dem Titel auf die Teilen-Schaltfläche. Dadurch wird ein Dialog geöffnet. Klicken Sie auf `Server starten`.

Standardmäßig wird der Server auf allen Schnittstellen über Port `28005` gehostet. Sie können dies im Dialog ändern. Sie müssen sicherstellen, dass dieser Server für den Client erreichbar ist.
Im lokalen Netzwerk sollte dies ohne weitere Einrichtung funktionieren. Wenn Sie vom Internet aus auf den Server zugreifen möchten, müssen Sie den Port in Ihrem Router weiterleiten. Weitere Informationen dazu finden Sie [hier](https://de.wikipedia.org/wiki/Portweiterleitung).

Wenn Sie den Port nicht weiterleiten können, können Sie einen Dienst wie [ngrok](https://ngrok.com/) verwenden. Dadurch wird ein Tunnel zu Ihrem lokalen Server erstellt. Das ist nützlich, wenn Sie das Dokument mit anderen Personen teilen möchten.

Für ngrok würde der Befehl so aussehen:

```bash
ngrok http 28005
```

### Mit dem Server verbinden

Nun müssen Sie Sie mit dem Server verbinden. Gehen Sie dazu zur Startseite und klicken Sie auf die Plus-Schaltfläche, als würden Sie ein neues Dokument erstellen. Dort sehen Sie einen neuen Menüpunkt namens `Verbinden`.

Klicken Sie darauf, dann wird ein Dialog angezeigt. Gib hier die Verbindungs-URL ein.
Wenn Sie sich im selben Netzwerk befinden, können Sie die lokale IP-Adresse des Computers verwenden, auf dem der Server läuft.
Die URL sollte so aussehen: `ws://{ip}:28005`. Ersetzen Sie `{ip}` durch die IP-Adresse des Computers. Sie finden die IP-Adresse unter Windows mit dem Befehl `ipconfig` oder unter Linux mit `ifconfig`. Unter Android finden Sie die IP-Adresse in den WLAN-Einstellungen.

Wenn Sie sich nicht im selben Netzwerk befinden, müssen Sie die öffentliche IP-Adresse des Computers verwenden. Sie finden sie, indem Sie in Ihrer bevorzugten Suchmaschine nach `what is my IP` suchst. Die URL sollte wie oben aussehen, aber mit der öffentlichen IP-Adresse.

Wenn Sie ngrok verwenden, ist die Einrichtung etwas anders. Ersetzen Sie `https` durch `wss` und fügen Sie am Ende den Port `:28005` hinzu. Die URL sollte so aussehen: `wss://{random}:28005`. Ersetzen Sie den zufälligen Teil durch den Teil, den ngrok Ihnen gibt.
