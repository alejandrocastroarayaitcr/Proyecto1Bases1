import Home from './pages/Home';
import Donations from './pages/Donations';
import Refunds from './pages/Refunds';
import Header from './components/Header'
import { useState } from 'react';

function Router(props){
    const [currentPage, setCurrentPage] = useState("HOME")
    const page = new Map()

    page.set("HOME", (<Home/>))
    page.set("MONEY", (<Donations/>))
    page.set("REFUND", (<Refunds/>))

    return (
        <>   
        <Header setPage={setCurrentPage}/>
        {page.get(currentPage)}
        </>
    )
}

export default Router