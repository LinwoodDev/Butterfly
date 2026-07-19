import { registerSW } from 'virtual:pwa-register'
import './sidebar'

console.log("registering SW")
registerSW({
  immediate: true,
  onRegisteredSW(swScriptUrl) {
    console.log('SW registered: ', swScriptUrl)
  },
  onOfflineReady() {
    console.log('PWA application ready to work offline')
  },
})
