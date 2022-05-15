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
import { AnimationOnScroll } from 'react-animation-on-scroll';

function HomepageHeader() {
  const [platform, setPlatform] = React.useState('');
  React.useEffect(() => {
    const parser = new UAParser();
    const uaPlatform = parser.getOS().name;
    // Test if it is a linux distro
    if (['Raspbian', 'Debian', 'Ubuntu', 'Linux Mint', 'Fedora', 'Arch', 'CentOS', 'Red Hat', 'Manjaro'].includes(uaPlatform)) {
      setPlatform('Linux');
    } else {
      setPlatform(uaPlatform);
    }
  }, []);
  const { siteConfig } = useDocusaurusContext();
  const Svg = require('../../static/img/logo.svg').default;
  return (
    <header className={clsx('hero shadow--lw', styles.heroBanner)}>
      <div className="container">
        <Svg data-aos="fade-down" height="15em" width="15em" alt="Logo" />
        <h1 data-aos="fade-up" className="hero__title">
          {siteConfig.title}
        </h1>
        <p data-aos="fade-up" className="hero__subtitle">
          {siteConfig.tagline}
        </p>
        <div className={styles.indexCtas}>
          <AnimationOnScroll animateIn="animate__fadeInLeft">
            <Link data-aos="fade-right"
              className="button button--secondary button--lg"
              to="/docs/1.1/intro">
              <Translate description="homepage getting started button">
                Getting started
              </Translate>
            </Link>
          </AnimationOnScroll>
          <AnimationOnScroll animateIn="animate__fadeInUp">
            {platform === 'Windows' &&
              <Link
                className="button button--success button--lg"
                to="/downloads/windows">
                <Translate description="homepage windows button">
                  Download for Windows
                </Translate>
              </Link>
            }
            {platform === 'Linux' &&
              <Link
                className="button button--success button--lg"
                to="/downloads/linux">
                <Translate description="homepage linux button">
                  Download for Linux
                </Translate>
              </Link>
            }
            {platform === 'Android' &&
              <Link
                className="button button--success button--lg"
                to="/downloads/android">
                <Translate description="homepage android button">
                  Download for Android
                </Translate>
              </Link>
            }
            <Link
              className="button button--warning button--lg"
              to="https://butterfly.linwood.dev">
              <Translate description="homepage web button">
                Open the web app
              </Translate>
            </Link>
          </AnimationOnScroll>
          <AnimationOnScroll animateIn="animate__fadeInRight">
            <Link
              className="button button--info button--lg"
              to="/downloads">
              <Translate description="homepage downloads button">
                Downloads
              </Translate>
            </Link>
          </AnimationOnScroll>
        </div>
      </div>
    </header>
  );
}

export default function Home() {
  const { siteConfig } = useDocusaurusContext();
  return (
    <Layout
      title={`Hello from ${siteConfig.title}`}
      description="Change the world">
      <HomepageHeader />
      <main>
        <HomepageFeatures />
        <img data-aos="fade-up"
          src={require('../../static/img/main.png').default}
          className={styles.screenshot}
          alt="Screenshot"
        />
      </main>
    </Layout>
  );
}
