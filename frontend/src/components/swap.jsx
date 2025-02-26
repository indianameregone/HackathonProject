import Nav from '../assets/banner'
import { AppKitProvider } from '../assets/config'
import useFetch from '../useFetch'
import '../App.css'
import '../index.css'

function swap() {  
    const {data, loading} = useFetch("https://api.coinlore.net/api/tickers/")    
    return (   
      
      <div className="card">
        <AppKitProvider />
        <Nav />
        <h1>Swap</h1>
      </div>
    )
  }

export default swap