import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
import Nav from './assets/banner'
import { AppKitProvider, ConnectButton } from './assets/config'

function App() {
  return (  
    <AppKitProvider>
      <div className="card">
        <Nav />
        <h1>Hackathon App</h1>
      </div>
    </AppKitProvider>
  )
}

export default App
