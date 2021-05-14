function DonationsItem(props){
    return (<div className="donations-item">
        <p className="sub-title"><strong>Canal: {props.donation.ChannelName}</strong></p>
        <p className="sub-title"><strong>Cantidad: </strong>${props.donation.DonationAmount}</p>
        <p className="sub-title"><strong>Fecha:</strong> {props.donation.DateOfDonation}</p>
        <p className="sub-title"><strong>Mensaje:</strong> {props.donation.DonationMessage}</p>
    </div>)
}

export default DonationsItem