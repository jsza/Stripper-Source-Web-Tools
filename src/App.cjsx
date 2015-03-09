React = require('react')
{RouteHandler} = require('react-router')
{Nav, Navbar} = require('react-bootstrap')
{NavItemLink} = require('react-router-bootstrap')



App = React.createClass
    render: ->
        <div className="inherit-height">
            <Navbar brand="Stripper:Source Tools" inverse fixedTop fluid>
                <Nav>
                    <NavItemLink to="bsp">BSP Info</NavItemLink>
                    <NavItemLink to="laser">Laser Shapes</NavItemLink>
                </Nav>
            </Navbar>
            <div className="container-fluid" style={paddingTop: '51px'}>
                <RouteHandler {...@props} />
            </div>
        </div>



module.exports = App
