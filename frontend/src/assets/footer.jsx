import React from "react";
import './nav.css'
import '../index.css'
import facebook from '../img/facebook.png'
import instagram from '../img/instagram.png'
import twitter from '../img/twitter.png'


const Footer = ()=>{
    return(
        <div className="Foot-Nav">
            <img src={facebook} alt="social media" />
            <img src={instagram} alt="social media" />
            <img src={twitter} alt="social media" />
        </div>
    )
}

export default Footer