import fetch from 'node-fetch';
import fs from 'fs';

// Fetch version value fromy yaml file https://raw.githubusercontent.com/LinwoodCloud/Butterfly/nightly/app/pubspec.yaml
const nightlyUrl = 'https://raw.githubusercontent.com/LinwoodCloud/Butterfly/nightly/app/pubspec.yaml';
const nightlyVersion = await fetch(nightlyUrl).then(res => res.text()).then(text => {
    const regex = /^version:\s(.+)\+(.+)$/gm;
    const match = regex.exec(text);
    return match[1];
}
);

// stable
const stableUrl = 'https://raw.githubusercontent.com/LinwoodCloud/Butterfly/stable/app/pubspec.yaml';
const stableVersion = await fetch(stableUrl).then(res => res.text()).then(text => {
    const regex = /^version:\s(.+)\+(.+)$/gm;
    const match = regex.exec(text);
    return match[1];
}
);

// develop
const developUrl = 'https://raw.githubusercontent.com/LinwoodCloud/Butterfly/develop/app/pubspec.yaml';
const developVersion = await fetch(developUrl).then(res => res.text()).then(text => {
    const regex = /^version:\s(.+)\+(.+)$/gm;
    const match = regex.exec(text);
    return match[1];
}
);

// main
const mainUrl = 'https://raw.githubusercontent.com/LinwoodCloud/Butterfly/main/app/pubspec.yaml';
const mainVersion = await fetch(mainUrl).then(res => res.text()).then(text => {
    const regex = /^version:\s(.+)\+(.+)$/gm;
    const match = regex.exec(text);
    return match[1];
}
);

// Write nightly and stable version to meta.json
const meta = {
    version: {
        nightly: nightlyVersion,
        stable: stableVersion,
        develop: developVersion,
        main: mainVersion,
    }
};

// Write to static/meta.json
const metaPath = 'static/meta.json';
// Create meta.json if it doesn't exist
if (!fs.existsSync(metaPath)) {
    fs.writeFileSync(metaPath, JSON.stringify(meta));
}