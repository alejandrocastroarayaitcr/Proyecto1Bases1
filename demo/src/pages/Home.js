import axios from 'axios';
import { useEffect, useState } from 'react';
import Categories from '../components/Categories'
import ChannelItems from '../components/ChannelItems'

const urlCategories = 'http://localhost:3000/top_categories_viewers'

function App() {
  const [categories, setCategories] = useState([])

  useEffect(()=>{
    axios.get(urlCategories).then(r=>{
      setCategories(r.data)
    })
  }, [])

  return (
    <div>
      <div>
        <Categories categoriesList={categories}/>
        <ChannelItems categories={categories}/>
      </div>
    </div>
  );
}

export default App;
