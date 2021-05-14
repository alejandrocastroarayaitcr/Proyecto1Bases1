function Category(props){
    const category = props.category;
    
    return (
        <div className="category container grid">
            <p><strong>{category.Category}</strong></p>
            <p>Viewers: {category.Viewers}</p>
        </div>
    )
}

export default Category