import './nav.css'
import '../index.css'
import { ConnectButton } from './config'
import { Link } from 'react-router-dom'


function nav() {

  return (  
        <div className="Nav-Bar">
          <ul>
            <li><Link style={{ textDecoration: 'none',color: "whitesmoke" }} to="/">Home</Link></li>
            <li><Link style={{ textDecoration: 'none',color: "whitesmoke" }} to="/Staking">Staking</Link></li>
            <li><Link style={{ textDecoration: 'none',color: "whitesmoke" }} to="/Swap">Swap</Link></li> 
              <ConnectButton />            
          </ul>
        </div> 
  )
}

export default nav
