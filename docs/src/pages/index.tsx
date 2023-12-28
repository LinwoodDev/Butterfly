import React from 'react';
import clsx from 'clsx';
import Layout from '@theme/Layout';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import styles from './index.module.css';
import HomepageFeatures from "../components/HomepageFeatures";
import Translate from '@docusaurus/Translate';
import "animate.css/animate.min.css";
import UAParser from 'ua-parser-js';
import {useDocsVersionCandidates} from '@docusaurus/theme-common/internal';
import { AnimationOnScroll } from 'react-animation-on-scroll';
import HomepageDescription from '../components/HomepageDescription';
import { DownloadAppButton } from '../components/DownloadButton';

function HomepageHeader({
  docsPluginId}) {
  const {siteConfig} = useDocusaurusContext();
  const version = useDocsVersionCandidates(docsPluginId)[0];
  return (
    <header className={clsx('hero shadow--lw', styles.heroBanner)}>
      <div className="container">
        <div className="row">
          <div className={clsx("col col--6", styles.center)}>
            <h1 data-aos="fade-up" className="hero__title">
              {siteConfig.title}
            </h1>
            <p data-aos="fade-up" className="hero__subtitle">
              {siteConfig.tagline}
            </p>
            <div className={styles.indexCtas}>
              <AnimationOnScroll animateIn="animate__fadeInLeft">
                <DownloadAppButton className={styles.button} />
              </AnimationOnScroll>
              <AnimationOnScroll animateIn="animate__fadeInUp">
                <Link className={clsx("button button--outline button--lg button--secondary", styles.button)}
                  to={`${version.path}/intro`}>
                  <Translate description="homepage getting started button">
                    Getting started
                  </Translate>
                </Link>
              </AnimationOnScroll>
            </div>
          </div>
          <div className={clsx("col col--6", styles.center)}>
            <img
              src={require('../../static/img/main.png').default}
              className={styles.screenshot}
              alt="Screenshot"
            />
          </div>
        </div>
      </div>
    </header>
  );
}

export default function Home({docsPluginId}) {
  const { siteConfig } = useDocusaurusContext();
  return (
    <Layout
      title={`Hello from ${siteConfig.title}`}
      description="Change the world">
      <HomepageHeader docsPluginId={docsPluginId} />
      <main>
        <HomepageDescription />
        <HomepageFeatures />
      </main>
    </Layout>
  );
}
