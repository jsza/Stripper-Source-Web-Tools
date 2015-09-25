import React from 'react'

import {Panel, Table} from 'react-bootstrap'


export default class InputsPanel extends React.Component {
  renderInputs() {
    let inputs = []
    if (this.props.entity.kv.targetname)
      this.props.entities.forEach((entity) => {
        entity.outputs.forEach((output) => {
          if (output.target === this.props.entity.kv.targetname) {
            inputs.push({e: entity, o: output})
          }
        })
      })

    return inputs.map((i) =>
      <tr>
        <td><a href="#">{i.e.kv.targetname || i.e.kv.classname}</a></td>
        <td>{i.o.trigger}</td>
        <td>{i.o.input}</td>
        <td>{i.o.parameters}</td>
        <td>{i.o.delay}</td>
        <td>{i.o.onlyOnce === '-1' ? 'No' : 'Yes'}</td>
      </tr>
    )
  }

  render() {
    return (
      <Panel className="entity-info-panel">
        <Table bordered condensed hover style={{marginBottom: 0}}>
          <thead>
            <th>Source</th>
            <th>Output</th>
            <th>My Input</th>
            <th>Parameter</th>
            <th>Delay</th>
            <th>Only once</th>
          </thead>
          <tbody>{this.renderInputs()}</tbody>
        </Table>
      </Panel>
    )
  }
}
