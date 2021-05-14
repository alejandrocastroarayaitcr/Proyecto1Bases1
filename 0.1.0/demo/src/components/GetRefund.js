import axios from "axios"
import { useState } from "react"

const url = "http://localhost:8080/api/refund"

function GetRefund(props){
    const [tran, setTran] = useState("")

    const inputChange = (e) => {
        setTran(e.target.value)
    }

    const sendData = e => {
        let body = {
            tran : tran
        }
        console.log(tran)
        axios.post(url, body)
        .then(r => alert("Reembolso completo!"))
        .catch(error => {
            if (error.response){
                alert(error.response.data.error)
            }
        })
    }

    return (<div>
        <p className="title"><strong>Obtener reembolso</strong></p>
        <input onChange={e=>inputChange(e)} type="text" placeholder="Numero de transaccion..." />
        <button className="fetch-button" onClick={(e) => sendData(e)}>
            Submit 
        </button>
    </div>)
}

export default GetRefund