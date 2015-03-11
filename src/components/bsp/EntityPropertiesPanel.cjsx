React = require('react')

{Panel, Table} = require('react-bootstrap')
_ = require('underscore')



InputsPanel = React.createClass
    renderKeyValues: ->
        keys = _.keys(@props.entity.kv).sort()

        return keys.map((k) =>
            isOutput = _.find(@props.entity.outputs, (o) -> return o.trigger == k)
            if isOutput or k == 'classname'
                return
            v = @props.entity.kv[k]
            <tr>
                <th>{k}</th>
                <td>{v}</td>
            </tr>
        )


    render: ->
        <Panel className="entity-info-panel">
            <Table bordered condensed hover style={marginBottom: 0}>
                <tbody>{@renderKeyValues()}</tbody>
            </Table>
        </Panel>



module.exports = InputsPanel
