import axios from "axios"
import { useState } from "react"

const url = "http://localhost:8080/api/change_status"

function ChangeStatus(props){
    const [tran, setTran] = useState("")
    const [accepted, setAccepted] = useState(true)

    const onSelectChange = e => {
        setAccepted(e.target.value)
    }
    
    const onInputChange = e => {
        setTran(e.target.value)
    }

    const sendData = e => {
        let body = {
            tran : tran,
            accepted : accepted,
            opt : 1
        }
        
        axios.post(url, body)
        .then(r => alert("Cambio de estado completo!"))
        .catch(error => {
            if (error.response){
                alert(error.response.data.error)
            }
        })
    }

    return (<div>
        <p className="title"><strong>Cambiar estado de Pago</strong></p>
        <input onChange={onInputChange} type="text" placeholder="Numero de transaccion..." />
        <select value={accepted} onChange={onSelectChange}>
            <option value={true}>Aceptado</option>
            <option value={false}>Rechazado</option>
        </select>
        <button className="fetch-button" onClick={sendData}>
            Submit 
        </button>
    </div>)
}

export default ChangeStatus