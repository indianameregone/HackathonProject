import './nav.css'
import '../index.css'
import { ConnectButton } from './config'
function nav() {


  return (  
    <>
        <div className="Nav-Bar">
          <ul>
            <li>Menu</li>
            <li>Us</li>
            <li>currency</li>
            <ConnectButton className="conn"/>
          </ul>
        </div>  
    </>   
       
    
  )
}

export default nav
