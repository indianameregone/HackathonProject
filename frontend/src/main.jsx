import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.jsx'
import { BrowserRouter } from 'react-router-dom'
import { AppKitProvider } from './assets/config'

createRoot(document.getElementById('root')).render(
  <BrowserRouter>
    <AppKitProvider>
      <App />
    </AppKitProvider>
  </BrowserRouter>,
)
