import React from 'react'
import _ from 'underscore'

import {readEntities} from '../utils/bsp/Parser'

import {Panel, Table} from 'react-bootstrap'
import BSPDropzone from '../components/bsp/BSPDropzone'


export default class ServercommandApp extends React.Component {
  constructor(props) {
    super(props)
    this.state = {maps: null, errors: null}
  }


  onClickReset(e) {
    e.preventDefault()
    this.setState({maps: null, errors: null})
  }


  handleFiles(files) {
    let maps = {}
    let errors = {}
    let ds = []

    let foo = function(file) {
      return (entities) =>
        maps[file.name] = this.extractServercommands(entities)
    }
    foo = foo.bind(this)

    function handleError(filename, error) {
      errors[filename] = error
    }

    for (var i = 0; i < files.length; i++) {
      const file = files[i]
      ds.push(readEntities(file).catch((e) => handleError(file.name, e))
        .then(foo(file)).catch((e) => handleError(file.name, e))
      )
    }

    Promise.all(ds).then(() => this.setState({maps: maps, errors: errors}))
  }


  extractServercommands(entities) {
    let things = []
    for (let entity of entities) {
      if (entity.kv.classname === 'point_servercommand') {
        const inputs = entity.inputs.map((input) => {
          if (input.o.input.toLowerCase().trim() === 'command') {
            return input
          }
        })
        if (inputs.length > 0) {
          things.push(
            { entity: entity
            , inputs: inputs
            })
        }
      }
    }
    return things
  }


  renderServercommands(commands) {
    return commands.map((command) => {
      const e = command.entity
      const inputs = command.inputs

      const items = inputs.map((i) => {
        if (i.e.kv.targetname) {
          const name = (
            <span>
            </span>
          )
          const title = i.e.kv.classname + ''
        }
        return (
          <tr>
            <td><a href="#">{i.e.kv.classname} ({i.e.kv.targetname})</a></td>
            <td>{i.o.trigger}</td>
            <td>{i.o.input}</td>
            <td>{i.o.parameters}</td>
            <td>{i.o.delay}</td>
            <td>{i.o.onlyOnce === '-1' ? 'No' : 'Yes'}</td>
          </tr>
        )
      })
      const header = (
        <span className="clearfix">
          <strong>{e.kv.targetname}</strong>
          <span className="text-muted"> ( {e.kv.origin} )</span>
        </span>
      )
      return (
        <div>
          <Panel header={header}>
            <h4 className="no-margin"></h4>
            <Table condensed hover style={{backgroundColor: 'white', marginBottom: 0}}>
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
    })
  }


  renderItems() {
    const keys = _.keys(this.state.maps).sort()
    return keys.map((k) => {
      const commands = this.state.maps[k]
      if (commands.length > 0) {
        const header = (
          <strong>{k}</strong>
        )
        return (
          <Panel header={header} bsStyle="info" collapsable={false}>
            {this.renderServercommands(commands)}
          </Panel>
        )
      }
    })
  }


  renderErrors() {
    if (!this.state.errors || Object.keys(this.state.errors).length === 0) {
      return null
    }

    const keys = _.keys(this.state.errors).sort()
    const errors = keys.map((k) => {
      const error = this.state.errors[k].toString()
      return (
        <Panel header={<strong>{k}</strong>} bsStyle="danger" collapsable={false}>
          {error}
        </Panel>
      )
    })

    return (
      <div>
        <h4>Errors</h4>
        {errors}
      </div>
    )
  }


  render() {
    let content
    if (this.state.maps !== null) {
      content = this.renderItems()
    }
    else {
      content = [
        <p>Select one or more BSPs to see the output.</p>,
        <BSPDropzone handleFiles={this.handleFiles.bind(this)} />
      ]
    }
    return (
      <div>
        <h2>point_servercommand checker <button className="btn btn-link" onClick={this.onClickReset.bind(this)}>reset</button></h2>
        {content}
        {this.renderErrors()}
      </div>
    )
  }
}
