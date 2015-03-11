React = require('react')

{Panel, Table} = require('react-bootstrap')
{BSPActions} = require('../../actions')



OutputsPanel = React.createClass
    onClickTargetname: (targetname) ->
        BSPActions.setKeyValueFilter('targetname', targetname)


    renderOutputs: ->
        outputs = @props.entity.outputs

        return outputs.map((o) =>
            <tr>
                <td>{o.trigger}</td>
                <td>
                    <a href="#" onClick={@onClickTargetname.bind(this, o.target)}>{o.target}</a>
                </td>
                <td>{o.input}</td>
                <td>{o.parameters}</td>
                <td>{o.delay}</td>
                <td>{if o.onlyOnce == '-1' then 'No' else 'Yes'}</td>
            </tr>
        )


    render: ->
        <Panel className="entity-info-panel">
            <Table bordered condensed hover style={marginBottom: 0}>
                <thead>
                    <th>My Output</th>
                    <th>Target</th>
                    <th>Target Input</th>
                    <th>Parameter</th>
                    <th>Delay</th>
                    <th>Only once</th>
                </thead>
                <tbody>{@renderOutputs()}</tbody>
            </Table>
        </Panel>



module.exports = OutputsPanel
