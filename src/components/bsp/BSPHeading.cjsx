React = require('react')
{BSPActions} = require('../../actions')



BSPHeading = React.createClass
    onClickUnload: (e) ->
        e.preventDefault()
        BSPActions.flushStore()


    render: ->
        if @props.fileName
            subHeading = (
                <small>
                    {@props.fileName} <a href="#" onClick={@onClickUnload}>unload</a>
                </small>
            )
        else
            subHeading = ''
        <h3>
            BSP Entity Viewer {subHeading}
        </h3>



module.exports = BSPHeading
