import DonationsFor from '../components/DonationsFor'
import DonationsSince from '../components/DonationsSince'

function Donations(props){
    return (
        <div>
            <DonationsSince/>
            <DonationsFor/>
        </div>
    )
}

export default Donations