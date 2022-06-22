import React from 'react'


export default function DownloadButton({className, href, children}) {
    function onClick(e) {
        // Open thank you page after download
        console.log('Downloading...')
        setTimeout(() => {
            window.location.href = "/downloads/thank-you";
        }, 500);
    }
    return (
        <a className={className} href={href} download target="_blank" onClick={onClick}>{children}</a>
    );
}