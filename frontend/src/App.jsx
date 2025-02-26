import './App.css'
import './index.css'
import Home from './components/home'
import Staking from './components/staking'
import Swap from './components/swap'
import { Route,Routes } from 'react-router-dom'

   
  
function App() {  
   
  return (    
    <Routes>
      <Route path='/' element={<Home />} />
      <Route path='/Staking' element={<Staking />} />
      <Route path='/Swap' element={<Swap />} />
    </Routes>
  )
}

export default App
