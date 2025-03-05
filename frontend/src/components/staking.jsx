import Nav from '../assets/banner'
import { AppKitProvider } from '../assets/config'
import useFetch from '../useFetch'
import Footer from '../assets/footer'
import '../App.css'
import '../index.css'
import { ConnectButton } from '../assets/config'
import { Link } from 'react-router-dom'

function stacking() {  
    const {data, loading} = useFetch("https://api.coinlore.net/api/tickers/")    
    return (   
      
      <div className="card">
        <AppKitProvider />
        <div className="Nav-Bar">
          <ul>
            <li><Link style={{ textDecoration: 'none',color: "whitesmoke" }} to="/">Home</Link></li>
            <li><Link style={{ textDecoration: 'none',color: "whitesmoke",fontSize:'25px',textShadow:'3px 3px rgb(12, 19, 231)' }} to="/Staking">Staking</Link></li>
            <li><Link style={{ textDecoration: 'none',color:'whitesmoke'}} to="/Swap">Swap</Link></li> 
              <ConnectButton />            
          </ul>
        </div> 
        <h1>Staking</h1>
        <Footer />
      </div>
    )
  }

export default stacking