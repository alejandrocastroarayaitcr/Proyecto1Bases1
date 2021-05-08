import axios from 'axios'
import { useEffect, useRef, useState } from 'react'
import ChannelItem from './ChanneItem'

const urlBase = 'http://localhost:3000/top_lives_streams_for_category?categoryName='

function ChannelItems(props){
    const [channels, setChannels] = useState(new Map())

    let categories = props.categories.slice(0, 3)

    useEffect(()=>{
        fetchChannels(categories)
        .then(r => {
            setChannels(r)
        })
    }, [categories.length])

    return (<div className="channel-items grid">
            {generateCategories(categories, channels)}
        </div>)
}

async function fetchChannels(categories){
    let results = new Map()

    for (let i = 0; i < categories.length; i++){
        results.set(categories[i].Category, await (await axios(urlBase+categories[i].Category)).data)
    }

    return results
}

function generateCategories(categories, channels){
    return categories.map((category, index)=>{
        let channel = channels.get(category.Category)
        
        return (<li key={index} className="channels-container">
            <p className="title"><strong>{category.Category}</strong></p>
            {generateChannels(channel)}
        </li>)
    })
}

function generateChannels(channels){
    return (channels === undefined) ? (<div></div>) : channels.map((channel, index)=>
        <ChannelItem key={index} channelItem={channel}/>
    )
}

export default ChannelItems