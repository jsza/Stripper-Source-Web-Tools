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
        <div className="panel panel-default entity-info-panel">
            <div className="panel-body entity-info-panel-body">
                <Table bordered condensed hover >
                    <tbody>{@renderKeyValues()}</tbody>
                </Table>
            </div>
        </div>



module.exports = InputsPanel
