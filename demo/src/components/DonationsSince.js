import axios from 'axios'
import { useState } from 'react'
import DonationsItems from './DonationsItems'

const url = "http://localhost:3000/all_donations_since?sinceDATE="

function DonationsSince(props){
    const [donations, setDonations] = useState([])

    const HandleChange = e => {
        axios.get(url + e.target.value)
        .then(r => setDonations(r.data))
    }

    return (
        <div className="donations-since-container">
            <p className="title"><strong>Donaciones desde: </strong></p>
            <input type="date"  onChange={HandleChange}/>
            <DonationsItems donations={donations}/>
        </div>
    )
}

export default DonationsSince