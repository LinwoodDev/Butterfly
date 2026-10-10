# Butterfly Documentation

[![Built with Starlight](https://astro.badg.es/v2/built-with-starlight/tiny.svg)](https://starlight.astro.build)

## 🚀 Project Structure

Inside of the docs directory, you'll see the following folders and files:

```
.
├── public/
├── src/
│   ├── assets/
│   ├── content/
│   │   ├── docs/
│   │   └── config.ts
│   └── env.d.ts
├── astro.config.mjs
├── package.json
└── tsconfig.json
```

Starlight looks for `.md` or `.mdx` files in the `src/content/docs/` directory. Each file is exposed as a route based on its file name.

Images can be added to `src/assets/` and embedded in Markdown with a relative link.

Static assets, like favicons, can be placed in the `public/` directory.

## Translations

Crowdin translates page content in `src/content/docs/` and UI labels in
`src/translations/*.json`, as configured in the root `crowdin.yml`. Add new UI
labels to `src/translations/en.json`; the shared Linwood Starlight plugin exposes these
dictionaries through Starlight's `Astro.locals.t()` API with English fallback.
Sidebar labels use the same dictionaries.

Write internal page links as root-relative paths, such as `/docs/v2/intro/`.
The shared plugin localizes hero actions and rendered Markdown and MDX links
using the current locale. This also
works for Starlight's fallback content without changing the source strings
Crowdin translates. Links with an explicit locale, external URLs, anchors, and
static asset links are preserved.

## 🧞 Commands

All commands are run from the root of the project, from a terminal:

| Command                   | Action                                           |
| :------------------------ | :----------------------------------------------- |
| `pnpm install`             | Installs dependencies                            |
| `pnpm dev`             | Starts local dev server at `localhost:4321`      |
| `pnpm build`           | Build your production site to `./dist/`          |
| `pnpm preview`         | Preview your build locally, before deploying     |
| `pnpm astro ...`       | Run CLI commands like `astro add`, `astro check` |
| `pnpm astro -- --help` | Get help using the Astro CLI                     |

## Version metadata

`/meta.json` reads app versions from local Git refs without making HTTP requests.
The `nightly` and `stable` channels use their release tags; `develop` and `main`
use the corresponding `origin` branch refs. Local builds reflect the last fetched
versions, not uncommitted changes in `app/pubspec.yaml`.

To populate or refresh these refs before building, run this from the checkout:

```sh
git fetch --no-tags --depth=1 origin \
  +refs/tags/nightly:refs/tags/nightly \
  +refs/tags/stable:refs/tags/stable \
  +refs/heads/develop:refs/remotes/origin/develop \
  +refs/heads/main:refs/remotes/origin/main
```

The documentation deployment workflow runs this fetch before building. Missing
refs or invalid versions fail the build rather than publishing incomplete metadata.

## 👀 Want to learn more?

Check out [Starlight’s docs](https://starlight.astro.build/), read [the Astro documentation](https://docs.astro.build), or jump into the [Astro Discord server](https://astro.build/chat).
