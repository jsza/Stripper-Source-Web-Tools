React = require('react')
{TabbedArea, TabPane, Table} = require('react-bootstrap')
_ = require('underscore')



objectToStripper = (object) ->
    result = ''
    _.keys(object).sort().forEach(
        (key) ->
            result += '    "' + key + '" "' + object[key] + '"\n'
    )
    return '{\n' + result + '}'



EntityInfoPanel = React.createClass
    renderKeyValues: ->
        keys = []
        for k, v of @props.selectedEntity
            keys.push(k)
        keys.sort()

        return keys.map((k) =>
            <tr style={fontSize: '12px'}>
                <th>{k}</th>
                <td>{@props.selectedEntity[k]}</td>
            </tr>
        )


    render: ->
        if @props.selectedEntity
            return (
                <TabbedArea animation={false}>
                    <TabPane eventKey={1} tab="Properties">
                        <div className="panel panel-default entity-info-panel">
                            <div className="panel-body">
                                <Table bordered condensed hover style={marginBottom: 0}>
                                    <tbody>{@renderKeyValues()}</tbody>
                                </Table>
                            </div>
                        </div>
                    </TabPane>
                    <TabPane eventKey={2} tab="Inputs">
                        <div className="panel panel-default entity-info-panel">
                            <div className="panel-body">
                                ...
                            </div>
                        </div>
                    </TabPane>
                    <TabPane eventKey={3} tab="Outputs">
                        <div className="panel panel-default entity-info-panel">
                            <div className="panel-body">
                                ...
                            </div>
                        </div>
                    </TabPane>
                    <TabPane eventKey={4} tab="Raw">
                        <div className="panel panel-default entity-info-panel">
                            <div className="panel-body">
                                <pre style={marginBottom: 0}>
                                    {objectToStripper(@props.selectedEntity)}
                                </pre>
                            </div>
                        </div>
                    </TabPane>
                </TabbedArea>
            )
        return <div />



module.exports = EntityInfoPanel
