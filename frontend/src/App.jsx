import './App.css'
import './index.css'
import Nav from './assets/banner'
import { AppKitProvider, ConnectButton } from './assets/config'

function App() {
  return (      
    <div className="card">
        <Nav />
      <AppKitProvider>
        <h1>Hackathon App</h1>     
      </AppKitProvider>
    </div>
  )
}

export default App
