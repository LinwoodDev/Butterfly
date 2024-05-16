{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();

    await appRunner.runApp();
    window.setTimeout(function () {
      removeSplashFromWeb();
    }, 200);
  }
});
