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
        keys = _.keys(@props.selectedEntity.kv).sort()

        return keys.map((k) =>
            if @props.selectedEntity.outputs[k] != undefined or k == 'classname'
                return
            v = @props.selectedEntity.kv[k]
            <tr>
                <th>{k}</th>
                <td>{v}</td>
            </tr>
        )


    renderOutputs: ->
        keys = _.keys(@props.selectedEntity.outputs)

        return keys.map((k) =>
            v = @props.selectedEntity.outputs[k]

            things = v.split(',').map((x) ->
                <td>{x}</td>
            )

            <tr>
                <th>{k}</th>
                {things}
            </tr>
        )


    render: ->
        if @props.selectedEntity
            return (
                <div>
                    <h4 className="no-margin" style={textDecoration: 'underline', marginBottom: '5px'}>{@props.selectedEntity.kv.classname}</h4>
                    <TabbedArea animation={false}>
                        <TabPane eventKey={1} tab="Properties" disabled>
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
                                    Not implemented yet
                                </div>
                            </div>
                        </TabPane>
                        <TabPane eventKey={3} tab="Outputs">
                            <div className="panel panel-default entity-info-panel">
                                <div className="panel-body">
                                    <Table bordered condensed hover style={marginBottom: 0}>
                                        <thead>
                                            <th>Name</th>
                                            <th>Target</th>
                                            <th>Input</th>
                                            <th>Parameters</th>
                                            <th>Delay</th>
                                            <th>Only once</th>
                                        </thead>
                                        <tbody>{@renderOutputs()}</tbody>
                                    </Table>
                                </div>
                            </div>
                        </TabPane>
                        <TabPane eventKey={4} tab="Raw">
                            <div className="panel panel-default entity-info-panel">
                                <div className="panel-body">
                                    <pre style={marginBottom: 0}>
                                        {objectToStripper(@props.selectedEntity.kv)}
                                    </pre>
                                </div>
                            </div>
                        </TabPane>
                    </TabbedArea>
                </div>
            )
        return <div />



module.exports = EntityInfoPanel
