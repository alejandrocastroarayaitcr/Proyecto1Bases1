import DonationsItem from './DonationsItem'

function DonationsItems(props){
    const items = props.donations.map((donation, index)=>{
        return (
            <li key={index}>
                <DonationsItem donation={donation} />
            </li>
        )
    })

    return (<ul className="donations-items">
        {items}
    </ul>)
}

export default DonationsItems