/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
  title: 'Linwood Butterfly Docs',
  tagline: 'Next future, advanced, serverless, free note app',
  url: 'https://docs.butterfly.linwood.dev',
  baseUrl: '/',
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/favicon.ico',
  organizationName: 'LinwoodCloud', // Usually your GitHub org/user name.
  projectName: 'butterfly', // Usually your repo name.
  themeConfig: {
    navbar: {
      title: 'Linwood Butterfly',
      logo: {
        alt: 'Linwood Butterfly Logo',
        src: 'img/logo.svg',
      },
      items: [
        {
          type: 'doc',
          docId: 'intro',
          position: 'left',
          label: 'Tutorial',
        },
        {
          to: 'downloads',
          label: 'Downloads',
          position: 'left'
        },
        {href: 'https://linwood.dev/blog', label: 'Blog', position: 'left'},
        {
          type: 'docsVersionDropdown',
          position: 'right'
        },
        {
          href: 'https://github.com/LinwoodCloud/Butterfly',
          label: 'GitHub',
          position: 'right',
        }
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Community',
          items: [
            {
              label: 'Discord',
              href: 'https://discord.linwood.dev',
            },
            {
              label: 'Twitter',
              href: 'https://twitter.com/LinwoodCloud',
            },
          ],
        },
        {
          title: 'Source code',
          items: [
            {
              label: 'App',
              href: 'https://github.com/LinwoodCloud/butterfly/tree/develop/app',
            },
            {
              label: 'Docs',
              href: 'https://github.com/LinwoodCloud/butterfly/tree/develop/docs',
            }
          ],
        },
        {
          title: 'Legal',
          items: [
            {
              label: 'Imprint',
              href: 'https://codedoctor.tk/impress',
            },
            {
              label: 'Privacy Policy',
              href: '/privacypolicy',
            },
          ],
        }
      ],
      copyright: `Copyright © ${new Date().getFullYear()} LinwoodCloud.`,
    },
  },
  presets: [
    [
      '@docusaurus/preset-classic',
      {
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          editUrl:
            'https://github.com/LinwoodCloud/butterfly/edit/develop/docs/',
        },
        blog: false,
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      },
    ],
  ],
  plugins: [
    [
      '@docusaurus/plugin-client-redirects',
      {
        redirects: [
          {
            to: '/privacypolicy', // string
            from: ['/docs/privacypolicy'], // string | string[]
          },
        ],
      },
    ],
  ]
};
