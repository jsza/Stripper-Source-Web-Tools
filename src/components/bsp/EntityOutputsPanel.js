import React from 'react'

import {Panel, Table} from 'react-bootstrap'
import {BSPActions} from '../../actions'


export default class OutputsPanel extends React.Component {
  onClickTargetname(targetname) {
    BSPActions.setKeyValueFilter('targetname', targetname)
  }

  renderOutputs() {
    const outputs = this.props.entity.outputs

    return outputs.map((o) =>
      <tr>
        <td>{o.trigger}</td>
        <td>
          <a href="#" onClick={this.onClickTargetname.bind(this, o.target)}>{o.target}</a>
        </td>
        <td>{o.input}</td>
        <td>{o.parameters}</td>
        <td>{o.delay}</td>
        <td>{o.onlyOnce == '-1' ? 'No' : 'Yes'}</td>
      </tr>
    )
  }


  render() {
    return (
      <Panel className="entity-info-panel">
        <Table bordered condensed hover style={{marginBottom: 0}}>
          <thead>
            <th>My Output</th>
            <th>Target</th>
            <th>Target Input</th>
            <th>Parameter</th>
            <th>Delay</th>
            <th>Only once</th>
          </thead>
          <tbody>{this.renderOutputs()}</tbody>
        </Table>
      </Panel>
    )
  }
}
