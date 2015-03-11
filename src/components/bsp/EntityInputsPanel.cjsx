React = require('react')

{Panel, Table} = require('react-bootstrap')



InputsPanel = React.createClass
    renderInputs: ->
        inputs = []
        if @props.entity.kv.targetname
            @props.entities.forEach((entity) =>
                entity.outputs.forEach((output) =>
                    if output.target == @props.entity.kv.targetname
                        inputs.push({e: entity, o: output})
                )
            )

        return inputs.map((i) ->
            <tr>
                <td><a href="#">{i.e.kv.targetname or i.e.kv.classname}</a></td>
                <td>{i.o.trigger}</td>
                <td>{i.o.input}</td>
                <td>{i.o.parameters}</td>
                <td>{i.o.delay}</td>
                <td>{if i.o.onlyOnce == '-1' then 'No' else 'Yes'}</td>
            </tr>
        )


    render: ->
        <Panel className="entity-info-panel">
            <Table bordered condensed hover style={marginBottom: 0}>
                <thead>
                    <th>Source</th>
                    <th>Output</th>
                    <th>My Input</th>
                    <th>Parameter</th>
                    <th>Delay</th>
                    <th>Only once</th>
                </thead>
                <tbody>{@renderInputs()}</tbody>
            </Table>
        </Panel>



module.exports = InputsPanel
