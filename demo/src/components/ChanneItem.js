function ChannelItem(props){
    const ChannelItem = props.channelItem

    return (<div className="category container grid">
        <p><strong>{ChannelItem.title}</strong></p>
        <p><strong>{ChannelItem.ChannelName}</strong></p>
        <p>{ChannelItem.currentViewers}</p>
    </div>)
}

export default ChannelItem