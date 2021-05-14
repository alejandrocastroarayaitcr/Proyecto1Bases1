import Category from './Category'

function Categories(props){
    const categoriesList = props.categoriesList

    const list = categoriesList.map((category, index)=>{
        return (<li key={index} >
            <Category category={category}/>
        </li>)
    })

    return (
        <div>
            <p className="title"><strong>Categorias más visitadas</strong></p>
            <div className="categories-container">
                {list}
            </div>
        </div>
    )
}

export default Categories