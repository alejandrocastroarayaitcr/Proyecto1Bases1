import axios from 'axios'
import {useEffect, useState } from 'react'
import DonationsItems from './DonationsItems'

const url = "http://localhost:3000/donations_for_channel?channelName=Florentino"

function DonationsFor(props){
    const [donationsFor, setDonationsFor] = useState("")

    const inputChange = e => {
        setDonationsFor(e.target.value);

    }

    const fetchData = (e) => {
        e.preventDefault()

        axios.get(url)
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
            <input type = "text" value = {donationsFor} onChange={inputChange} placeholder = "Nombre del canal" />
            <button className = "fetch-button" onClick={(e) => fetchData(e)}>
                Submit 
            </button>

            <div className="donationsFor">
        {donationsFor &&
          donationsFor.map((donation, index) => {

            return (
              <div className="donation" key={index}>
                <h3>Donation {index + 1}</h3>
                <h2>{donation.ChannelName}</h2>

                <div className="details">
                  <p>📖: {donation.SumDonationsReceived} </p>
                </div>
              </div>
            );
          })}
      </div>

            
        </div>
    )
}

export default DonationsFor