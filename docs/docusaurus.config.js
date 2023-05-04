const redirects = require("./redirects.js");

/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
  title: "Linwood Butterfly",
  tagline:
    "🎨 Powerful, minimalistic, cross-platform, opensource note-taking app 🎨",
  url: "https://docs.butterfly.linwood.dev",
  baseUrl: "/",
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/favicon.ico",
  organizationName: "LinwoodDev", // Usually your GitHub org/user name.
  projectName: "butterfly", // Usually your repo name.
  i18n: {
    defaultLocale: "en",
    locales: ["en", "de", "fr", "es", "it", "pt-BR", "th", "tr", "ru", "af", "ar", "ca", "cs", "da", "el", "fi", "he", "hu", "ja", "ko", "nl", "no", "pl", "ro", "sr", "sv", "uk", "vi", "zh", "zh-Hant"],
  },
  themeConfig: {
    colorMode: {
      defaultMode: "dark",
      disableSwitch: false,
      respectPrefersColorScheme: true,
    },
    algolia: {
      // The application ID provided by Algolia
      appId: "PQN0C3O7D3",

      // Public API key: it is safe to commit it
      apiKey: "219c0a938f5cec6e889c1e5edaef7035",

      indexName: "docs-butterfly-linwood",

      //... other Algolia params
    },
    navbar: {
      title: "Butterfly",
      logo: {
        alt: "Butterfly Logo",
        src: "img/logo.svg",
      },
      items: [
        {
          type: "doc",
          docId: "intro",
          position: "left",
          label: "Tutorial",
        },
        {
          to: "downloads",
          label: "Downloads",
          position: "left",
        },
        {
          type: "doc",
          docId: "community",
          docsPluginId: "community",
          position: "left",
          label: "Community",
        },
        {
          type: "dropdown",
          label: "More",
          position: "left",
          items: [
            {
              label: "Matrix",
              href: "https://linwood.dev/matrix",
            },
            {
              label: "Discord",
              href: "https://discord.linwood.dev",
            },
            {
              label: "GitHub",
              href: "https://github.com/LinwoodDev/Butterfly",
            },
            {
              label: "Blog",
              href: "https://linwood.dev/blog",
            },
            {
              label: "Crowdin",
              href: "https://go.linwood.dev/butterfly/crowdin",
            },
            {
              label: "Twitter",
              href: "https://twitter.com/LinwoodDev",
            },
            {
              label: "Mastodon",
              href: "https://floss.social/@linwood",
            },
            {
              label: "License",
              href: "https://go.linwood.dev/butterfly/license",
            },
          ],
        },
        {
          type: "docsVersionDropdown",
          position: "right",
          dropdownItemsBefore: [],
          dropdownItemsAfter: [{ to: "/versions", label: "All versions" }],
          dropdownActiveClassDisabled: true,
        },
        {
          type: "localeDropdown",
          position: "right",
          dropdownItemsAfter: [
            {
              to: "https://translate.linwood.dev/butterfly",
              label: "Help translate",
            },
          ],
        },
      ],
    },
    footer: {
      style: "dark",
      links: [
        {
          title: "Community",
          items: [
            {
              label: "Discord",
              href: "https://discord.linwood.dev",
            },
            {
              label: "Matrix",
              href: "https://linwood.dev/matrix",
            },
            {
              label: "Twitter",
              href: "https://twitter.com/LinwoodDev",
            },
            {
              label: "Mastodon",
              href: "https://floss.social/@linwood",
            },
            {
              html: `
                <a href="https://vercel.com?utm_source=Linwood&utm_campaign=oss" target="_blank" rel="noreferrer noopener" aria-label="Deploys by Vercel">
                  <img src="/img/powered-by-vercel.svg" alt="Deploys by Vercel" />
                </a>
              `,
            },
          ],
        },
        {
          title: "Source code",
          items: [
            {
              label: "App",
              href: "https://github.com/LinwoodDev/butterfly/tree/develop/app",
            },
            {
              label: "Docs",
              href: "https://github.com/LinwoodDev/butterfly/tree/develop/docs",
            },
            {
              label: "Contribution guide",
              href: "https://github.com/LinwoodDev/butterfly/blob/develop/CONTRIBUTING.md",
            },
          ],
        },
        {
          title: "Legal",
          items: [
            {
              label: "Imprint",
              href: "https://go.linwood.dev/imprint",
            },
            {
              label: "Privacy Policy of the app",
              href: "/privacypolicy",
            },
            {
              label: "Privacy Policy of the website",
              href: "https://go.linwood.dev/privacypolicy",
            },
          ],
        },
      ],
      logo: {
        alt: "Linwood Logo",
        src: "https://linwood.dev/logos/logo.png",
        width: 100,
        href: "https://linwood.dev",
      },
      copyright: `Copyright © ${new Date().getFullYear()} Linwood.`,
    },
  },
  presets: [
    [
      "@docusaurus/preset-classic",
            /** @type {import('@docusaurus/preset-classic').Options} */
      {
        docs: {
          sidebarPath: require.resolve("./sidebars.js"),
          editUrl: ({locale, docPath}) => {
            if (locale !== 'en') {
              return `https://translate.linwood.dev/butterfly/${locale}`;
            }
            return `https://github.com/LinwoodDev/butterfly/edit/develop/docs/docs`;
          },
          versions: {
            current: {
              label: "Nightly",
              path: "2.0",
            },
            1.6: {
              label: "1.6.1",
              path: "1.6",
            },
            1.5: {
              label: "1.5.1",
              path: "1.5",
            },
            1.4: {
              label: "1.4.3",
              path: "1.4",
            },
            1.3: {
              label: "1.3.2",
              path: "1.3",
            },
            1.2: {
              label: "1.2.1",
              path: "1.2",
            },
            1.1: {
              label: "1.1.2",
              path: "1.1",
            },
            "1.0": {
              label: "1.0.0",
              path: "1.0",
              banner: "unmaintained",
            },
          },
        },
        blog: false,
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      },
    ],
  ],
  plugins: [
    [
      "@docusaurus/plugin-content-docs",
      {
        id: "community",
        path: "community",
        routeBasePath: "/",
        sidebarPath: require.resolve("./sidebarsCommunity.js"),
      },
    ],
    [
      "@docusaurus/plugin-client-redirects",
      {
        redirects: redirects,
      },
    ],
    [
      "@docusaurus/plugin-pwa",
      {
        offlineModeActivationStrategies: [
          "appInstalled",
          "standalone",
          "queryString",
        ],
        pwaHead: [
          {
            tagName: "link",
            rel: "icon",
            href: "/img/logo.png",
          },
          {
            tagName: "link",
            rel: "manifest",
            href: "/manifest.json", // your PWA manifest
          },
          {
            tagName: "meta",
            name: "theme-color",
            content: "#f2b138",
          },
        ],
      },
    ],
    // Other tweaks
  ],

  webpack: {
    jsLoader: (isServer) => ({
      loader: require.resolve("swc-loader"),
      options: {
        jsc: {
          parser: {
            syntax: "typescript",
            tsx: true,
          },
          target: "es2017",
        },
        module: {
          type: isServer ? "commonjs" : "es6",
        },
      },
    }),
  },
};
