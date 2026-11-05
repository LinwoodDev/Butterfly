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
│   │   └── i18n/
│   ├── content.config.ts
│   └── env.d.ts
├── astro.config.mjs
├── package.json
└── tsconfig.json
```

Starlight looks for `.md` or `.mdx` files in the `src/content/docs/` directory. Each file is exposed as a route based on its file name.

Images can be added to `src/assets/` and embedded in Markdown with a relative link.

Static assets, like favicons, can be placed in the `public/` directory.

## Shared styling

Landing pages use `Landing` and `LandingFeature` from
`@linwooddev/starlight-style`. Keep layout and card styles in the shared library;
`src/styles/custom.scss` only defines Butterfly's colors. Both Linwood packages
are pinned to the same shared-library commit in `package.json` and `pnpm-lock.yaml`.

The shared plugin also configures heading IDs and GitHub emoji replacements.
Butterfly opts into its math support with `linwoodStarlight({ math: true })`;
the shared package supplies KaTeX rendering, styles, and fonts. Math is disabled
by default for other sites.

## Translations

The site uses [Starlight's internationalization system](https://starlight.astro.build/guides/i18n/).
English is the root and default locale: English pages live directly in
`src/content/docs/`, and translated pages use the same relative filename under
their language directory (for example, `de/docs/v2/intro.mdx`). Starlight generates
missing translations from the English page and displays its untranslated-content
notice automatically. Leave untranslated pages absent to use this fallback.

Crowdin translates page content and UI labels in `src/content/i18n/*.json`, as
configured in the root `crowdin.yml`. `src/content.config.ts` calls the shared
package's `createCollections(en)` to register Starlight's docs and i18n loaders
and schemas. Add custom UI keys to `src/content/i18n/en.json`;
the schema includes them as optional strings so other languages can fall back to
English. Built-in Starlight UI strings are already translated and can be
overridden in these JSON files. Render UI strings with `Astro.locals.t("key")`.

UI filenames use the locale's BCP-47 `lang` tag (`en.json`, `pt-BR.json`,
`zh-Hant.json`), while content directories use the configured locale paths
(`pt-br/`, `zh-hant/`). Crowdin maps these variants separately. Internal sidebar
links use locale-independent slugs (for example, `docs/v2/intro`) so Starlight
uses the translated page's title or `sidebar.label` frontmatter. Group headings
and deliberate label overrides reuse the UI dictionaries through Starlight's
`translations` option, prepared by the shared package's
`createI18n(new URL("./src/content/i18n/", import.meta.url))`. This helper also
derives the language list, native language names, URL paths, and text direction
from the dictionaries. Add a language JSON file to enable that locale; no manual
`locales` block is needed. English remains the default and root language.
The shared style plugin supplies its own default UI strings; site dictionaries
are loaded by Starlight's content collection.

Butterfly also enables `detectLanguage: true` in the shared plugin. On an
unprefixed page, a small, dismissible popup offers the browser's preferred
supported language. The page never switches language automatically. The visitor
can accept the suggestion, keep the current language, or close the popup.
The native picker and popup remember manual choices, including English.
Explicit language URLs are respected. Language choices preserve query parameters
and fragments, and the popup also works after ClientRouter navigation.

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
