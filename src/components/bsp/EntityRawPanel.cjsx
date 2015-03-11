React = require('react')

{objectToStripper} = require('../../utils/keyvalues')
{Panel} = require('react-bootstrap')



RawEntityPanel = React.createClass
    render: ->
        <Panel className="entity-info-panel">
            <pre style={marginBottom: 0}>
                {objectToStripper(@props.entity.kv)}
            </pre>
        </Panel>



module.exports = RawEntityPanel
