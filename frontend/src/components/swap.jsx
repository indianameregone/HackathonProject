import Nav from '../assets/banner'
import { AppKitProvider } from '../assets/config'
import useFetch from '../useFetch'
import { useState } from 'react'
import { useWalletClient, usePublicClient, useWriteContract, useAccount } from 'wagmi'
import { parseEther } from 'viem'
import { CONTRACT_ADDRESSES } from '../utils/contracts'
// Add ABI imports
import ETokenABI from '../../../contract/out/EToken.sol/EToken.json'
import ESwapABI from '../../../contract/out/ESwap.sol/ESwap.json'
import USDCTestABI from '../../../contract/out/USDCTest.sol/USDCTest.json'
import '../App.css'
import '../index.css'
import Footer from '../assets/footer'
import { ConnectButton } from '../assets/config'
import { Link } from 'react-router-dom'

function swap() {  
    const [sell,setSell] = useState('') //type of crypto currency we will sell
    const [but,setBuy] = useState('') //type of crypto currency we want to buy
    const [sellopt, setSellopt] = useState('')  //how much money will try to swap
    const {data, fetchLoading} = useFetch("https://api.coinlore.net/api/tickers/")  
    
    // Use wagmi hooks
    const { address } = useAccount()
    const { data: walletClient } = useWalletClient()
    const publicClient = usePublicClient()
    const { writeContractAsync } = useWriteContract()
    const [loading, setLoading] = useState(false)
    const [error, setError] = useState(null)
    const [success, setSuccess] = useState(false)

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
    const testEnv = ()=>{
      document.getElementsByClassName('card')[0].style.setProperty('--uno','grey') 
      document.getElementsByClassName('card')[0].style.setProperty('--siete','grey') 
      document.getElementsByClassName('main-sect')[0].style.setProperty('--nueve','grey') 
      document.getElementsByClassName('main-sect')[1].style.setProperty('--nueve','grey') 
      document.getElementsByClassName('swapbtn')[0].style.setProperty('--nueve','grey') 
      document.getElementsByClassName('enviroment')[0].style.setProperty('--nueve','grey') 
      document.getElementsByClassName('enviroment')[0].children[0].style.setProperty('--ocho','grey') 
      document.getElementsByClassName('enviroment')[0].children[1].style.setProperty('--ocho','grey')       
      document.getElementsByClassName('Foot-Nav')[0].style.setProperty('--ocho','grey') 
      document.getElementsByClassName('Nav-Bar')[0].style.setProperty('--nueve','grey')
      document.getElementById('realID').style.visibility = 'visible'
      document.getElementById('testID').style.visibility = 'hidden'
      
      
      
      
      
      
    }
    const realEnv = ()=>{
      document.getElementsByClassName('card')[0].style.setProperty('--uno','#effef0')   
      document.getElementsByClassName('card')[0].style.setProperty('--siete','#0d881c')   
      document.getElementsByClassName('main-sect')[0].style.setProperty('--nueve','#0f581a') 
      document.getElementsByClassName('main-sect')[1].style.setProperty('--nueve','#0f581a') 
      document.getElementsByClassName('swapbtn')[0].style.setProperty('--nueve','#0f581a')    
      document.getElementsByClassName('enviroment')[0].style.setProperty('--nueve','#0f581a')  
      document.getElementsByClassName('enviroment')[0].children[0].style.setProperty('--ocho','#106b1c') 
      document.getElementsByClassName('enviroment')[0].children[1].style.setProperty('--ocho','#106b1c')        
      document.getElementsByClassName('Foot-Nav')[0].style.setProperty('--ocho','#106b1c') 
      document.getElementsByClassName('Nav-Bar')[0].style.setProperty('--nueve','#0f581a') 
      document.getElementById('realID').style.visibility = 'hidden'
      document.getElementById('testID').style.visibility = 'visible'
    }
   
    // Add swap handler
    const handleSwap = async () => {
      if (!address) {
        setError('Please connect your wallet first')
        return
      }

      try {
        setLoading(true)
        setError(null)
        
        const amount = parseEther(sellopt.toString())

        // First approve the swap
        console.log('Approving token spend...')
        const approveHash = await writeContractAsync({
          address: CONTRACT_ADDRESSES.ETOKEN,
          abi: ETokenABI.abi,
          functionName: 'approve',
          args: [CONTRACT_ADDRESSES.ESWAP, amount]
        })

        // Wait for approval transaction
        await publicClient.waitForTransactionReceipt({ hash: approveHash })

        // Then perform the swap
        console.log('Performing swap...')
        const swapHash = await writeContractAsync({
          address: CONTRACT_ADDRESSES.ESWAP,
          abi: ESwapABI.abi,
          functionName: 'swapAtoB',
          args: [amount]
        })

        // Wait for swap transaction
        await publicClient.waitForTransactionReceipt({ hash: swapHash })

        setSuccess(true)
        console.log('Swap completed!')
      } catch (err) {
        console.error('Swap failed:', err)
        setError(err.message || 'Swap failed')
      } finally {
        setLoading(false)
      }
    }

    return (   
      
      <div className="card">
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
          <fieldset className='enviroment'>            
            <button onClick={testEnv} id='testID'>Test</button>
            <button onClick={realEnv} id='realID'>Real</button>
          </fieldset>
          <section>          
            <fieldset className='main-sect'>
            <legend>I want to sell:</legend>
            <input type="number" placeholder=' Insert Quantity'  onChange={onChangeHandleopt} id='optnum'></input> 
            <select className='dropDown' onChange={onChangeHandlersell}>
              <option>Select Cryptocurrency</option>
              {fetchLoading && <h2>Loading....</h2>}
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
            {fetchLoading && <h2>Loading....</h2>}
            {data?.map((user)=>(
              <option key={user.name} className="container" id={user.name} price={user.price_usd} symbol={user.symbol}>
                <h2 >{user.symbol}</h2> 
              </option>         
              ))}
          </select>
            </fieldset>       
          </section>
          {/* Add error and success messages */}
          {error && <div className="error-message">{error}</div>}
          {success && <div className="success-message">Swap completed successfully!</div>}
          <button 
            className='swapbtn'
            onClick={handleSwap}
            disabled={loading || !address}
          >
            {loading ? 'Swapping...' : 'Swap Currency'}
          </button>
        </section>
        
        <Footer />

      </div>
    )
  }

export default swap