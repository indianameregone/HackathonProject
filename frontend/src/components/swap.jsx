import Nav from '../assets/banner'
import { AppKitProvider } from '../assets/config'
import useFetch from '../useFetch'
import { useState } from 'react'
import '../App.css'
import '../index.css'
import Footer from '../assets/footer'
import { ConnectButton } from '../assets/config'
import { Link } from 'react-router-dom'

function swap() {  
    const [sell,setSell] = useState('') //type of crypto currency we will sell
    const [but,setBuy] = useState('') //type of crypto currency we want to buy
    const [sellopt, setSellopt] = useState('')  //how much money will try to swap
    const {data, loading} = useFetch("https://api.coinlore.net/api/tickers/")  
    const onChangeHandlersell = (e) => {
      const index = e.target.selectedIndex;
      const el = e.target.childNodes[index]
      const option =  el.getAttribute('symbol');  
      console.log(option)
      setSell(option)
      
    }
    const onChangeHandlerbuy = (e) => {
      const index = e.target.selectedIndex;
      const el = e.target.childNodes[index]
      const option =  el.getAttribute('symbol');  
      console.log(option)
      setSell(option)
      
    }
    const onChangeHandleopt = (e) => {
      let option = document.getElementById('optnum').value  
      //console.log(option)
      setSellopt(option)
      
    }
    
   
    return (   
      
      <div className="card">
        <AppKitProvider />
        <div className="Nav-Bar">
          <ul>
            <li><Link style={{ textDecoration: 'none',color: "whitesmoke" }} to="/">Home</Link></li>
            <li><Link style={{ textDecoration: 'none',color: "whitesmoke" }} to="/Staking">Staking</Link></li>
            <li><Link style={{ textDecoration: 'none',color:'whitesmoke',fontSize:'25px',textShadow:'3px 3px rgb(12, 19, 231)'}} to="/Swap">Swap</Link></li> 
              <ConnectButton />            
          </ul>
        </div> 
        <section id='swap-sect'>
          <div className='imgByS'>          
          </div>
          <section>          
            <fieldset className='main-sect'>
            <legend>I want to sell:</legend>
            <input type="number" placeholder=' Insert Quantity'  onChange={onChangeHandleopt} id='optnum'></input> 
            <select className='dropDown' onChange={onChangeHandlersell}>
              <option>Select Cryptocurrency</option>
              {loading && <h2>Loading....</h2>}
              {data?.map((user)=>(
                <option key={user.name} className="container" id={user.name} price={user.price_usd} symbol={user.symbol}>
                  <h2 >{user.symbol}</h2> 
                </option>         
                ))}
          </select>
            </fieldset>
            <fieldset className='main-sect'>
            <legend>I want to buy:</legend>
            <input type="text" placeholder=' Insert Quantity' ></input> 
          <select className='dropDown' onChange={onChangeHandlerbuy}>
          <option>Select Cryptocurrency</option>
            {loading && <h2>Loading....</h2>}
            {data?.map((user)=>(
              <option key={user.name} className="container" id={user.name} price={user.price_usd} symbol={user.symbol}>
                <h2 >{user.symbol}</h2> 
              </option>         
              ))}
          </select>
            </fieldset>       
          </section>
          <button className='swapbtn'>Swap Currency</button>
        </section>
        
        <Footer />

      </div>
    )
  }

export default swap