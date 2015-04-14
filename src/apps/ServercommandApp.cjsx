React = require('react')
_ = require('underscore')

{readEntities, getEntityInputs} = require('../utils/bsp/Parser')

{Panel, Table, Well, Col, Row} = require('react-bootstrap')
BSPDropzone = require('../components/bsp/BSPDropzone')



ServercommandApp = React.createClass
    getInitialState: ->
        return {
            maps: null
        }


    onClickReset: (e) ->
        e.preventDefault()
        @setState({maps: null})


    handleFiles: (files) ->
        maps = {}
        ds = []

        foo = (file) =>
            return (entities) =>
                maps[file.name] = @extractServercommands(entities)

        for file in files
            ds.push(readEntities(file)
                .then(foo(file)).catch(-> null)
            )

        Promise.all(ds).then(
            =>
                @setState({maps: maps})
        )


    extractServercommands: (entities) ->
        things = []
        for entity in entities
            if entity.kv.classname == 'point_servercommand'
                inputs = entity.inputs.map((input) ->
                    if input.o.input.toLowerCase().trim() == 'command'
                        return input
                )
                if inputs.length > 0
                    things.push({
                        entity: entity
                        inputs: inputs
                    })
        return things


    renderServercommands: (commands) ->
        return commands.map((command) ->
            e = command.entity
            inputs = command.inputs

            items = inputs.map((i) ->
                if i.e.kv.targetname
                    name = (
                        <span>
                        </span>
                    )
                    title = i.e.kv.classname + ''
                <tr>
                    <td><a href="#">{i.e.kv.classname} ({i.e.kv.targetname})</a></td>
                    <td>{i.o.trigger}</td>
                    <td>{i.o.input}</td>
                    <td>{i.o.parameters}</td>
                    <td>{i.o.delay}</td>
                    <td>{if i.o.onlyOnce == '-1' then 'No' else 'Yes'}</td>
                </tr>
            )
            header = (
                <span className="clearfix">
                    <strong>{e.kv.targetname}</strong>
                    <span className="text-muted"> ( {e.kv.origin} )</span>
                </span>
            )
            return (
                <div>
                    <Panel header={header}>
                        <h4 className="no-margin"></h4>
                        <Table condensed hover style={backgroundColor: 'white', marginBottom: 0}>
                            <thead>
                                <th>Source</th>
                                <th>Output</th>
                                <th>My Input</th>
                                <th>Parameter</th>
                                <th>Delay</th>
                                <th>Only once</th>
                            </thead>
                            <tbody>{items}</tbody>
                        </Table>
                    </Panel>
                </div>
            )
        )


    renderItems: ->
        keys = _.keys(@state.maps).sort()
        return keys.map((k) =>
            commands = @state.maps[k]
            if commands.length > 0
                header = (
                    <strong>{k}</strong>
                )
                return (
                    <Panel header={header} bsStyle="info" collapsable={false}>
                        {@renderServercommands(commands)}
                    </Panel>
                )
        )


    render: ->
        if @state.maps != null
            content = @renderItems()
        else
            content = [
                <p>Select one or more BSPs to see the output.</p>
                <BSPDropzone handleFiles={@handleFiles} />
            ]
        <div>
            <h2>point_servercommand checker <button className="btn btn-link" onClick={@onClickReset}>reset</button></h2>
            {content}
        </div>



module.exports = ServercommandApp
