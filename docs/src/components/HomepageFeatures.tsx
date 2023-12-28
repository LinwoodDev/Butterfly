import React from 'react';
import clsx from 'clsx';
import styles from './HomepageFeatures.module.css';
import Translate from '@docusaurus/Translate';
import { DownloadAppButton } from './DownloadButton';

const Principals = [
    {
        title: (<Translate description="Features cross-platform title">Cross platform</Translate>),
        Svg: require('../../static/img/undraw_progressive_app_m-9-ms.svg').default,
        description: (
            <Translate description="Features cross-platform description">
                You can use the app on your phone, tablet, laptop, or desktop.
                The app is available on Linux, Android, and Windows.
                You can also use the app on the web.
            </Translate>
        ),
    },
    {
        title: (<Translate description="Features simple title">Simple and intuitive</Translate>),
        Svg: require('../../static/img/undraw_innovative_b409.svg').default,
        description: (
            <Translate description="Features simple description">
                Every tool is on the right place.
                Open the app and start drawing.
                Change your tools by clicking on it.
            </Translate>
        ),
    },
    {
        title: (<Translate description="Features customizable title">Customizable</Translate>),
        Svg: require('../../static/img/undraw_options_re_9vxh.svg').default,
        description: (
            <Translate description="Features customizable description">
                Change everything to your needs.
                Choose your custom color, create a palette and add your pages to the paper.
                The paper has an infinite size, perfect for your ideas and notes.
            </Translate>
        ),
    },
    {
        title: (<Translate description="Features local title">Choose where your data is stored</Translate>),
        Svg: require('../../static/img/undraw_sweet_home_dkhr.svg').default,
        description: (
            <Translate description="Features local description">
                You can choose to store your data locally or in your favorite cloud (webdav).
                You can also export your data to a file and import it again.
            </Translate>
        ),
    },
];

const Features = [
    {
        description: (
            <Translate description="Features infinite-canvas">
                Use the infinite canvas to illustrate your ideas
            </Translate>
        ),
    },
    {
        description: (
            <Translate description="Features elements">
                Use your pen, markdown or rich text to let your ideas flow
            </Translate>
        ),
    },
    {
        Svg: require('../../static/img/undraw_progressive_app_m-9-ms.svg').default,
        description: (
            <Translate description="Features imports">
                Load PDF, SVG, PNG and more files into your notes or take pictures from the camera
            </Translate>
        ),
    },
    {
        Svg: require('../../static/img/undraw_progressive_app_m-9-ms.svg').default,
        description: (
            <Translate description="Features structure">
                Structure your notes by adding areas and waypoints or use multiple pages
            </Translate>
        ),
    },
];

function Principal({ Svg, title, description }) {
    return (
        <div className={clsx('col col--3')}>
            <div className="text--center">
                <Svg className={styles.featureSvg} alt={title} />
            </div>
            <div className="text--center padding-horiz--md">
                <h3>{title}</h3>
                <p>{description}</p>
            </div>
        </div>
    );
}

export default function HomepageFeatures() {
    return (
        <section data-aos="fade-up" className={styles.features}>
            <div className="container">
                <h2>
                    <Translate description="Principals title">
                        Principals
                    </Translate>
                </h2>
                <div className="row">
                    {Principals.map((props, idx) => (
                        <Principal key={idx} {...props} />
                    ))}
                </div>
                <h2>
                    <Translate description="Showcase title">
                        Features
                    </Translate>
                </h2>
                <div className="row">
                    <div className="col col--6">
                        <img
                            src={require('../../static/img/main.png').default}
                            className={styles.showcaseImg}
                            alt="Screenshot"
                        />
                    </div>
                    <ul className="col col--6">
                        {Features.map((props, idx) => (
                            <li key={idx} className={`text-large vertical-center ${styles.showcaseText}`}>{props.description}</li>
                        ))}
                        <li className={`text-large ${styles.showcaseButton}`}>
                            <h2>
                                <Translate description="Download title">
                                    Download Butterfly today
                                </Translate>
                            </h2>
                            <DownloadAppButton />
                        </li>
                    </ul>
                </div>
            </div>
        </section>
    );
}
