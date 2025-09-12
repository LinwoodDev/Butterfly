---
title: Zusammenarbeit
---

:::caution[🧪 Experiment]

Dieses Feature befindet sich hinter einer experimentellen Flag. Lesen Sie mehr [here](/nightly#experiments).
Alles in diesem Abschnitt kann geändert werden.

:::

## Einführung

Seit der Version 2.0 unterstützt Butterfly die Zusammenarbeit. Dies bedeutet, dass Sie die gleiche Datei mit mehreren Personen gleichzeitig bearbeiten können. Dies ist nützlich, wenn Sie an einem Dokument zusammenarbeiten möchten.

## Swamp

Swamp is a protocol that allows you to share your document with other people by using a remote server. This is useful if the other person is not in the same network as you. The server will just be a proxy for the connection and cannot read the data since it is all end to end encrypted.

### Setup Sawmp

Create a swamp server by visiting the [swamp website](https://swamp.linwood.dev).
Now enter the url of the server in the collaboration view. The url should look like this: `wss://example.com` or `ws://example.com`. Please note that only secure connections are allowed on the web. Please also make sure that the server is reachable from the internet.

Now you can just click on `Start` to start the server. With the given link you can share the document with other people. They can just enter the link in the connect dialog and click on `Connect`. This will connect them to the server and they will be able to edit the document.

## Websocket

Butterfly uses a websocket server that will be hosted on your computer. This server needs to be accessible from the internet or your local network. The client will connect to this server. The server sync all changes and events with all clients.

### Setup the server

:::note

This server feature is not available on the web.

:::

Firstly, enable the collaboration experiment in the settings. After that open your document you want to share. Then click on the share button in the top left corner right to the title. This will open a dialog. Click on `Start server`.

Default the server will be hosted on all interfaces on port `28005`. You can change this in the dialog. You need to make sure that this server is accessible to the client.
In the local network this should work out of the box. If you want to access the server from the internet, you need to forward the port in your router. You can find more information about this [here](https://en.wikipedia.org/wiki/Port_forwarding/).

If you cannot forward the port, you can use a service like [ngrok](https://ngrok.com/). This will create a tunnel to your local server. This is useful if you want to share the document with other people.

For ngrok the command would look like this:

```bash
ngrok http 28005
```

### Connect to the server

Now you need to connect to the server. To do this, go to the home page and click on the plus button like you would create a new document. There you will see a new menu item called `Connect`.

Click on this and you will see a dialog. Enter the connection url here.
If you are in the same network, you can use the local ip address of the computer where the server is running.
The url should look like this: `ws://{ip}:28005`. Replace `{ip}` with the ip address of the computer. You can find the ip address with the command `ipconfig` on windows or `ifconfig` on linux. On android you can find the ip address in the wifi settings.

If you are not in the same network, you need to use the public ip address of the computer. You can find this by searching for `what is my ip` in your favorite search browser. The url should look like the one above, but with the public ip address.

If you use ngrok, the setup is a bit different. Replace the `https` with `wss` and add the port `:28005` at the end. The url should look like this: `wss://{random}:28005`. Replace the random part with the part that ngrok gives you.
