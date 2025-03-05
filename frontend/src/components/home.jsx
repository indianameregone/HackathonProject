import Nav from '../assets/banner'
import { AppKitProvider } from '../assets/config'
import useFetch from '../useFetch'
import '../App.css'
import '../index.css'
import Footer from '../assets/footer'
import { ConnectButton } from '../assets/config'
import { Link } from 'react-router-dom'

function home() {  
    const {data, loading} = useFetch("https://api.coinlore.net/api/tickers/")    
    return (   
      
      <div className="card">
        <AppKitProvider />
        <div className="Nav-Bar">
          <ul>
            <li><Link style={{ textDecoration: 'none',color: "whitesmoke" ,fontSize:'25px',textShadow:'3px 3px rgb(12, 19, 231)'}} to="/">Home</Link></li>
            <li><Link style={{ textDecoration: 'none',color: "whitesmoke" }} to="/Staking">Staking</Link></li>
            <li><Link style={{ textDecoration: 'none',color:'whitesmoke'}} to="/Swap">Swap</Link></li> 
              <ConnectButton />            
          </ul>
        </div> 
        <div className='advBanner'>
          {loading && <h2>Loading....</h2>}
          {data?.map((user)=>(
            <div key={user.id} className="container">
              <h2 >{user.name}</h2> 
              <p>Price USD: {user.price_usd}</p>
            </div>         
            ))}
        </div>
        <Footer />
      </div>
    )
  }

export default home