import Nav from '../assets/banner'
import { AppKitProvider } from '../assets/config'
import useFetch from '../useFetch'
import Footer from '../assets/footer'
import '../App.css'
import '../index.css'

function stacking() {  
    const {data, loading} = useFetch("https://api.coinlore.net/api/tickers/")    
    return (   
      
      <div className="card">
        <AppKitProvider />
        <Nav />
        <h1>Staking</h1>
        <Footer />
      </div>
    )
  }

export default stacking