---
sidebar_label: Zusammenarbeit
sidebar_position: 4
title: Zusammenarbeit
---

:::warning 🧪 Experiment

Dieses Feature befindet sich hinter einer Versuchsflagge. Lesen Sie mehr [here](/nightly#experiments).
Alles in diesem Abschnitt ist freibleibend.

:::

## Einführung

Mit der Version 2.0 unterstützt Butterfly die Zusammenarbeit. Dies bedeutet, dass Sie die gleiche Datei mit mehreren Personen gleichzeitig bearbeiten können. Dies ist nützlich, wenn Sie an einem Dokument zusammenarbeiten möchten.

## So funktioniert es

Butterfly verwendet einen Websocket-Server, der auf Ihrem Computer gehostet wird. Dieser Server muss über das Internet oder Ihr lokales Netzwerk erreichbar sein. Der Client wird sich mit diesem Server verbinden. Der Server synchronisiert alle Änderungen und Ereignisse mit allen Clients.

## Server einrichten

:::note

Diese Serverfunktion ist im Web nicht verfügbar.

:::

Erstens, ermöglichen Sie das Experiment der Zusammenarbeit in den Einstellungen. Nach dem Öffnen des Dokuments, das Sie freigeben möchten. Dann klicken Sie auf den Teilen-Button in der linken oberen Ecke rechts zum Titel. Dies öffnet einen Dialog. Klicken Sie auf `Server starten`.

Standardmäßig wird der Server auf allen Schnittstellen auf Port `28005` gehostet. Sie können dies im Dialog ändern. Sie müssen sicherstellen, dass dieser Server für den Client zugänglich ist.
Im lokalen Netzwerk sollte dies aus der Box heraus funktionieren. Wenn Sie auf den Server aus dem Internet zugreifen möchten, müssen Sie den Port in Ihrem Router weiterleiten. Mehr Informationen zu diesem [here](https://de.wikipedia.org/wiki/Port_forwarding/).

Wenn du den Port nicht weiterleiten kannst, kannst du einen Dienst wie [ngrok](https://ngrok.com/) nutzen. Dies wird einen Tunnel für deinen lokalen Server erstellen. Dies ist nützlich, wenn Sie das Dokument mit anderen Personen teilen möchten.

Für ngrok würde der Befehl so aussehen:

```bash
ngrok http 28005
```

## Mit dem Server verbinden

Jetzt müssen Sie sich mit dem Server verbinden. Um dies zu tun, gehen Sie auf die Startseite und klicken Sie auf die Plus-Schaltfläche, da Sie ein neues Dokument erstellen würden. Dort wird ein neuer Menüeintrag namens `Connect` angezeigt.

Klicken Sie darauf und Sie sehen einen Dialog. Geben Sie hier die Verbindungs-URL ein.
Wenn Sie sich im selben Netzwerk befinden, können Sie die lokale IP-Adresse des Rechners verwenden, auf dem der Server läuft.
Die URL sollte so aussehen: `ws://{ip}:28005`. Ersetzen Sie `{ip}` durch die IP-Adresse des Computers. Du findest die IP-Adresse mit dem Befehl `ipconfig` auf Windows oder `ifconfig` auf linux. Auf Android finden Sie die IP-Adresse in den Wifi-Einstellungen.

Wenn Sie nicht im selben Netzwerk sind, müssen Sie die öffentliche IP-Adresse des Computers verwenden. Du kannst dies finden, indem du nach `Was ist mein ip` in deinem bevorzugten Such-Browser suchst. Die Url sollte wie die obige aussehen, aber mit der öffentlichen IP-Adresse.

Wenn Sie ngrok verwenden, ist das Setup etwas anders. Ersetzen Sie die `https` durch `wss` und fügen Sie den Port `:28005` am Ende hinzu. Die URL sollte so aussehen: `wss://{random}:28005`. Ersetzen Sie den zufälligen Teil mit dem Teil, den ngrok Ihnen gibt.
