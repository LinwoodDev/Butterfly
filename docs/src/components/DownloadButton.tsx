import Link from '@docusaurus/Link';
import Translate from '@docusaurus/Translate';
import clsx from 'clsx';
import React from 'react'
import UAParser from 'ua-parser-js';

export function DownloadAppButton({className} : {className?: string}) {
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
    return (<div className="dropdown dropdown--hoverable">
        <a href="/downloads" className={clsx("button button--primary button--lg", className)}>Download</a>
        <ul className="dropdown__menu">
            <li>
                {platform === 'Windows' &&
                    <Link
                        className="dropdown__link"
                        to="/downloads/windows">
                        <Translate description="homepage windows button">
                            Download for Windows
                        </Translate>
                    </Link>
                }
                {platform === 'Linux' &&
                    <Link
                        className="dropdown__link"
                        to="/downloads/linux">
                        <Translate description="homepage linux button">
                            Download for Linux
                        </Translate>
                    </Link>
                }
                {platform === 'Android' &&
                    <Link
                        className="dropdown__link"
                        to="/downloads/android">
                        <Translate description="homepage android button">
                            Download for Android
                        </Translate>
                    </Link>
                }
            </li>
            <li>
                <Link
                    className="dropdown__link"
                    to="https://butterfly.linwood.dev">
                    <Translate description="homepage web button">
                        Open the web app
                    </Translate>
                </Link>
            </li>
            <li>
                <Link
                    className="dropdown__link"
                    to="/downloads">
                    <Translate description="homepage downloads button">
                        Downloads
                    </Translate>
                </Link>
            </li>
        </ul>
    </div>);
}

export default function DownloadButton({ className, href, children, after }) {
    function onClick() {
        // Open thank you page after download
        console.log('Downloading...')
        setTimeout(() => {
            window.location.href = after ?? "/downloads/thank-you";
        }, 500);
    }
    return (
        <a className={className} href={href} download target="_blank" onClick={onClick}>{children}</a>
    );
}