import './App.css'
import './index.css'
import Nav from './assets/banner'
import { AppKitProvider } from './assets/config'
import BTCcard from './assets/btcCard'
import datas from './datas'
   
  
function App() {
  console.log(datas)
  return (   
    
    <div className="card">
      
        <Nav />
        <AppKitProvider />
        <section className='advBanner'>
          {datas.map((data)=>{
            return( 
              <BTCcard 
              name={data.name} 
              id={data.id} 
              price_btc={data.price_btc} 
              price_usd={data.price_usd} 
              key={data.id}/>                
              
            )
          })}  
        </section>
                   
    </div>
  )
}

export default App
