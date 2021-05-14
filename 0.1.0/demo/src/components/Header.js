function Header(props){
    return(
      <div>
        <header className="grid">
          <h1 className="header-logo">XTream</h1>
        </header>
        <p className="title"><strong>Menú (DEV MODE)</strong></p>
        <ul className="menu">
          <li onClick={()=>{redirect(props.setPage, "HOME")}}>Home</li>
          <li onClick={()=>{redirect(props.setPage, "MONEY")}}>Donaciones</li>
          <li onClick={()=>{redirect(props.setPage, "REFUND")}}>Reembolsos</li>
        </ul>
      </div>
        )
}

function redirect(setPage, url){
  setPage(url)
}

export default Header