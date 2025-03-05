import Nav from '../assets/banner'
import { AppKitProvider } from '../assets/config'
import useFetch from '../useFetch'
import '../App.css'
import '../index.css'
import Footer from '../assets/footer'

function swap() {  
    const {data, loading} = useFetch("https://api.coinlore.net/api/tickers/")    
    const onChangeHandler = (e) => {
      const index = e.target.selectedIndex;
      const el = e.target.childNodes[index]
      const option =  el.getAttribute('price');  
      console.log(option)
    }
    console.log(data)
   
    return (   
      
      <div className="card">
        <AppKitProvider />
        <Nav />
        <section id='swap-sect'>
        <h1>Swap</h1>
        <section>          
          <fieldset className='main-sect'>
          <legend>I want to sell:</legend>
          <input type="number" ></input> 
          <select className='dropDown' onChange={onChangeHandler}>
            <option>Select a currency</option>
            {loading && <h2>Loading....</h2>}
            {data?.map((user)=>(
              <option key={user.name} className="container" id={user.name} price={user.price_usd}>
                <h2 >{user.symbol}</h2> 
              </option>         
              ))}
        </select>
          </fieldset>
          <fieldset className='main-sect'>
          <legend>I want to buy:</legend>
          <input type="number"></input> 
        <select className='dropDown' onChange={onChangeHandler}>
        <option>Select a currency</option>
          {loading && <h2>Loading....</h2>}
          {data?.map((user)=>(
            <option key={user.name} className="container" id={user.name} price={user.price_usd}>
              <h2 >{user.symbol}</h2> 
            </option>         
            ))}
        </select>
          </fieldset>
       
        </section>
        </section>
        
        <Footer />

      </div>
    )
  }

export default swap