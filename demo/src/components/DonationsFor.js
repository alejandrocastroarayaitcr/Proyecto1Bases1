import axios from 'axios'
import { useState } from 'react'
import DonationsItems from './DonationsItems'

const url = "http://localhost:3000/donations_for_channel?channelName="

function DonationsFor(props){
    const [donations, setDonations] = useState([])

    const HandleChange = e => {
        axios.get(url + e.target.value)
        .then(r => setDonations(r.data))
    }

    return (
        <div className="donations-for-container">
            <p className="title"><strong>Donaciones para: </strong></p>
            <input type="text" onChange={HandleChange}/>
            <button>
                Submit 
            </button>
            <DonationsItems donations={donations}/>
        </div>
    )
}

export default DonationsFor