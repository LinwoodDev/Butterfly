import React from 'react';
import clsx from 'clsx';
import styles from './HomepageFeatures.module.css';
import Translate from '@docusaurus/Translate';

const FeatureList = [
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
    title: (<Translate description="Features local title">Your data will be saved locally</Translate>),
    Svg: require('../../static/img/undraw_sweet_home_dkhr.svg').default,
    description: (
      <Translate description="Features local description">
          Everything will be saved local on your computer.
          Export the notes as image or as json files which can be opened on a different device.
      </Translate>
    ),
  },
];

function Feature({Svg, title, description}) {
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
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
