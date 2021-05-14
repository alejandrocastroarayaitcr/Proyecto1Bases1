import axios from 'axios'
import {useEffect, useState } from 'react'
import DonationsItems from './DonationsItems'

const url = "http://localhost:3000/donations_for_channel?channelName="
var queryParam = ""

function DonationsFor(props){
    const [donationsFor, setDonationsFor] = useState("")

    const inputChange = (e) => {
        queryParam = e.target.value
        setDonationsFor(queryParam)

    }

    const fetchData = (e) => {
        e.preventDefault()

        axios.get(url+queryParam)
        .then((response)=>{
            setDonationsFor(response.data)
            console.log(response.data)
        })
        .catch((error) => {
            console.log(error)
        })
    }

    return (
        <div className="donations-for-container">
            <p className="title"><strong>Ver todas las donaciones para el canal: </strong></p>
            <input type = "text" value = {queryParam} onChange={(e) => inputChange(e)} placeholder = "Nombre del canal" />
            <button className = "fetch-button" onClick={(e) => fetchData(e)}>
                Submit 
            </button>

            <div className="donationsFor">
        {donationsFor && Array.isArray(donationsFor) &&
          donationsFor.map((donation, index) => {

            return (
              <div className="donation" key={index}>
                <p className="sub-title"><strong>Nombre de canal: </strong>{donation.ChannelName}</p>
                <p className="sub-title"><strong>Suma total de todas sus donaciones: 
                    </strong>{donation.SumDonationsReceived}</p>
              </div>
            );
          })}
      </div>

            
        </div>
    )
}

export default DonationsFor