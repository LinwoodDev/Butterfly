import React, { useState } from 'react'

export default function EmbedPlayground() {
  const [host, setHost] = useState("https://butterfly.linwood.dev")
  const [save, setSave] = useState(true)
  const [editable, setEditable] = useState(true)
  const [language, setLanguage] = useState("system")
  const url = `${host}/embed?save=${save}&editable=${editable}&language=${language}`;
  return (
    <div>
      <div className="input-group">
        <label htmlFor="language">Host</label>
        <input className="input" type="text" value={host} id="host" readOnly />
        <div className="grid">
            <button className="button button--outline button--secondary" onClick={() => setHost("https://butterfly.linwood.dev")}>Main</button>
            <button className="button button--outline button--secondary" onClick={() => setHost("https://preview.butterfly.linwood.dev")}>Preview</button>
            <button className="button button--outline button--secondary" onClick={() => setHost("https://v1.butterfly.linwood.dev")}>V1</button>
            <button className="button button--outline button--secondary" onClick={() => setHost("https://v2.butterfly.linwood.dev")}>V2</button>
        </div>
      </div>
      <label className="checkbox">Save
        <input type="checkbox" checked={save} id="save" onChange={() => setSave(!save)} />
        <span className="checkbox-checkmark"></span>
      </label>
      <label className="checkbox">Editable
        <input type="checkbox" checked={editable} id="editable" onChange={() => setEditable(!editable)} />
        <span className="checkbox-checkmark"></span>
      </label>
      <div className="input-group">
        <label htmlFor="language">Language</label>
        <input className="input" type="text" value={language} id="language" onChange={(e) => setLanguage(e.target.value)} />
      </div>
      <h2 className="padding-top--lg padding-bottom--sm">Preview</h2>
      <iframe src={url} width="100%" height="500px" allowTransparency={true}></iframe>
      <div className="input-group">
        <label htmlFor="url">Generated url</label>
        <input className="input" readOnly type="text" value={url} id="url" />
      </div>
    </div>
  )
}