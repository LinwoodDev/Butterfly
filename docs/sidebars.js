/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you want.
 */

module.exports = {
    // By default, Docusaurus generates a sidebar from the docs folder structure
    sidebar: [
        'intro',
        'color_picker',
        'migrating',
        {
            type: 'category',
            label: 'Backgrounds',
            link: {
                type: 'doc',
                id: 'background/intro'
            },
            items: [
                'background/quad',
                'background/ruled',
                'background/music'
            ]
        },
        {
            type: 'category',
            label: 'Painters',
            link: {
                type: 'doc',
                id: 'painters/intro'
            },
            items: [
                'painters/pen',
                'painters/eraser',
                'painters/path_eraser',
                'painters/label',
                'painters/image',
                'painters/layer'
            ]
        },
        {
            type: 'category',
            label: 'Tools',
            link: {
                type: 'doc',
                id: 'tools/intro',
            },
            items: [
                'tools/hand',
            ]
        }
    ],

    // But you can create a sidebar manually
    /*
    tutorialSidebar: [
      {
        type: 'category',
        label: 'Tutorial',
        items: ['hello'],
      },
    ],
     */
};
