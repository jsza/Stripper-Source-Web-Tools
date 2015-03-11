React = require('react')



BSPHeading = React.createClass
    render: ->
        if @props.fileName
            subHeading = (
                <small>
                    {@props.fileName} <a href="#">unload</a>
                </small>
            )
        else
            subHeading = ''
        <h3>
            BSP Entity Viewer {subHeading}
        </h3>



module.exports = BSPHeading
