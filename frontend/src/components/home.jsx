import Nav from '../assets/banner'
import { AppKitProvider } from '../assets/config'
import useFetch from '../useFetch'
import '../App.css'
import '../index.css'

function home() {  
    const {data, loading} = useFetch("https://api.coinlore.net/api/tickers/")    
    return (   
      
      <div className="card">
        <AppKitProvider />
        <Nav />
        <div className='advBanner'>
          {loading && <h2>Loading....</h2>}
          {data?.map((user)=>(
            <div key={user.id} className="container">
              <h2 >{user.name}</h2> 
              <p>Price USD: {user.price_usd}</p>
            </div>         
            ))}
        </div>
      </div>
    )
  }

export default home