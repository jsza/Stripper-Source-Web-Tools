React = require('react')



BSPHeading = React.createClass
    render: ->
        if @props.fileName
            subHeading = (
                <small>
                    {@props.fileName} <a href="#"><i className="fa fa-remove" /> unload</a>
                </small>
            )
        else
            subHeading = ''
        <h3>
            BSP Entity Viewer {subHeading}
        </h3>



module.exports = BSPHeading
