React = require('react')

{EntityFilterActions} = require('../../actions')



ServerCommandWarning = React.createClass
    onClick: (e) ->
        e.preventDefault()
        EntityFilterActions.setClassnameFilter('point_servercommand')


    render: ->
        if @props.classnameTally
            for [cn, cnt] in @props.classnameTally
                if cn == 'point_servercommand'
                    return (
                        <pre className="no-margin" style={marginTop: '10px'}>
                            <div className="text-warning">
                                WARNING: One or more <a href="#" onClick={@onClick}>point_servercommand</a> detected. Be sure to check their inputs.
                            </div>
                        </pre>
                    )
        return null



module.exports = ServerCommandWarning
