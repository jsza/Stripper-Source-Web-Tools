import React from 'react'
import {RouteHandler} from 'react-router'
import {Nav, Navbar} from 'react-bootstrap'
import {NavItemLink} from 'react-router-bootstrap'


export default class App extends React.Component {
  render() {
    return (
      <div className="inherit-height">
        <Navbar brand="Stripper:Source Tools" inverse fixedTop fluid toggleNavKey={0}>
          <Nav eventKey={0}>
            <NavItemLink to="bsp">BSP Info</NavItemLink>
            <NavItemLink to="servercommand">BSP Servercommand</NavItemLink>
            <NavItemLink to="laser">Laser Shapes</NavItemLink>
            <NavItemLink to="csgofixes">CS:GO Fixes</NavItemLink>
          </Nav>
        </Navbar>
        <div className="inherit-height container-fluid" style={{paddingTop: '51px'}}>
          <RouteHandler {...this.props} />
        </div>
      </div>
    )
  }
}
