function ChannelItem(props){
    const ChannelItem = props.channelItem

    return (<div className="channel-item">
        <p className="title"><strong>{ChannelItem.title}</strong></p>
        <p className="title"><strong>Canal: </strong>{ChannelItem.ChannelName}</p>
        <p className="sub-title"><strong>Espectadores:</strong> {ChannelItem.currentViewers}</p>
    </div>)
}

export default ChannelItem