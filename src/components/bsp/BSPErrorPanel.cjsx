React = require('react')
Reflux = require('reflux')

{Alert} = require('react-bootstrap')

{BSPActions} = require('../../actions')
BSPErrorStore = require('../../stores/BSPErrorStore')



BSPErrorPanel = React.createClass
    mixins: [Reflux.connect(BSPErrorStore, 'error')]

    onDismiss: ->
        BSPActions.dismissError()


    render: ->
        if @state.error
            <div>
                <br />
                <Alert bsStyle="danger" onDismiss={@onDismiss}>
                    <h4>Oh noes! An error!</h4>
                    <p>{@state.error}</p>
                </Alert>
            </div>
        else
            <div />



module.exports = BSPErrorPanel
