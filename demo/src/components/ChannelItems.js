import axios from 'axios'
import { useEffect, useRef, useState } from 'react'
import ChannelItem from './ChanneItem'

const urlBase = 'http://localhost:3000/top_lives_streams_for_category?categoryName='

function ChannelItems(props){
    const [channels, setChannels] = useState([])

    let categories = props.categories.slice(0, 3)

    useEffect(()=>{
        fetchChannels(categories)
        .then(r => {
            setChannels(r)
        })
    }, [categories])

    return (<div className="channel-items grid">
            {generateCategories(categories, channels)}
        </div>)
}

async function fetchChannels(categories){
    let results = new Map()

    for (let i = 0; i < categories.length; i++){
        results.set(categories[i].Category, await (await axios(urlBase+categories[i].Category)).data)
    }

    return Array.from(results)
}

function generateCategories(categories, channels){
    return categories.map((category, index)=>{
        return (<li key={index}>
            <p className="title"><strong>{category.Category}</strong></p>
            {generateChannels(channels)}
        </li>)
    })
}

function generateChannels(channels){
    console.log(channels)
}

export default ChannelItems