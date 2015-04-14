React = require('react')
{RouteHandler} = require('react-router')
{Nav, Navbar} = require('react-bootstrap')
{NavItemLink} = require('react-router-bootstrap')



App = React.createClass
    render: ->
        <div className="inherit-height">
            <Navbar brand="Stripper:Source Tools" inverse fixedTop fluid toggleNavKey={0}>
                <Nav eventKey={0}>
                    <NavItemLink to="bsp">BSP Info</NavItemLink>
                    <NavItemLink to="servercommand">BSP Servercommand</NavItemLink>
                    <NavItemLink to="laser">Laser Shapes</NavItemLink>
                </Nav>
            </Navbar>
            <div className="inherit-height container-fluid" style={paddingTop: '51px'}>
                <RouteHandler {...@props} />
            </div>
        </div>



module.exports = App
