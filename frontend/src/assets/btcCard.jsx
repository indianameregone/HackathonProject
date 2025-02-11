import React from "react";
import './nav.css'
import '../index.css'


const BTCcard = (props)=>{
    return(
        <div className="container">
            <h2>{props.name}</h2>
            <p>Price USD: {props.price_usd}</p>
        </div>
    )
}

export default BTCcard