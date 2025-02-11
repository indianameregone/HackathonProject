import './nav.css'
import '../index.css'
import { ConnectButton } from './config'


function nav() {

  return (  
    
    <>
        <div className="Nav-Bar">
          <ul>
            <li>Home</li>
            <li>Staking</li>
            <li>Swap</li> 
              <ConnectButton />            
          </ul>
        </div>  
    </>   
       
    
  )
}

export default nav
