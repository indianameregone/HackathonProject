import React from "react";
import './nav.css'
import '../index.css'


const BTCcard = (props)=>{
    return(
        <div className="container">
            <h2>Name: {props.name}</h2>
            <p>Id: {props.id}</p>
            <p>Price BTC: {props.price_btc}</p>
            <p>Price USD: {props.price_usd}</p>
        </div>
    )
}

export default BTCcard