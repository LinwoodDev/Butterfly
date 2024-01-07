---
sidebar_label: Colaboración
sidebar_position: 4
title: Colaboración
---

:::warning 🧪 Experimento

Esta característica está detrás de una bandera de experimento. Lee más [here](/nightly#experimentos).
Todo en esta sección está sujeto a cambios.

:::

## Introducción

Desde la versión 2.0 beta, la colaboración es compatible con Butterfly. Esto significa que puedes editar el mismo archivo con varias personas al mismo tiempo. Esto es útil si desea trabajar juntos en un documento.

## Cómo funciona

Butterfly utiliza un servidor websocket que será alojado en su computadora. Este servidor necesita ser accesible desde Internet o desde tu red local. El cliente se conectará a este servidor. El servidor sincroniza todos los cambios y eventos con todos los clientes.

## Configurar el servidor

:::note

Esta característica del servidor no está disponible en la web.

:::

En primer lugar, permitir el experimento de colaboración en los entornos. Después de esto, abra su documento que desea compartir. Luego haga clic en el botón compartir en la esquina superior izquierda derecha al título. Esto abrirá un diálogo. Haga clic en `Servidor de inicio`.

Por defecto el servidor se alojará en todas las interfaces del puerto `28005`. Puede cambiar esto en el diálogo. Debe asegurarse de que este servidor es accesible para el cliente.
En la red local esto debería funcionar de forma automática. Si desea acceder al servidor desde Internet, necesita redirigir el puerto desde su router. Puedes encontrar más información sobre esta [here](https://en.wikipedia.org/wiki/Port_forwarding/).

Si no puede reenviar el puerto, puede utilizar un servicio como [ngrok](https://ngrok.com/). Esto creará un túnel a su servidor local. Esto es útil si desea compartir el documento con otras personas.

Para ngrok el comando se vería así:

```bash
ngrok http 28005
```

## Conectar al servidor

Ahora necesita conectarse al servidor. Para ello, vaya a la página de inicio y haga clic en el botón más como crear un nuevo documento. Allí verá un nuevo elemento de menú llamado `Connect`.

Haga clic en esto y verá un diálogo. Introduzca la url de conexión aquí.
Si está en la misma red, puede utilizar la dirección IP local del equipo donde se está ejecutando el servidor.
La url debería verse así: `ws://{ip}:28005`. Reemplaza `{ip}` con la dirección IP del ordenador. Puede encontrar la dirección IP con el comando `ipconfig` en windows o `ifconfig` en linux. En android puedes encontrar la dirección IP en los ajustes de wifi.

Si no está en la misma red, necesita utilizar la dirección IP pública del equipo. Puedes encontrar esto buscando `lo que es mi ip` en tu navegador de búsqueda favorito. La url debería verse como la anterior, pero con la dirección IP pública.

Si usas ngrok, la configuración es un poco diferente. Reemplaza el `https` con `wss` y añade el puerto `:28005` al final. La url debería verse así: `wss://{random}:28005`. Reemplaza la parte aleatoria con la que te da ngrok.
