import React from 'react'

import {Table} from 'react-bootstrap'
import _ from 'underscore'


export default class InputsPanel extends React.Component {
  renderKeyValues() {
    const keys = _.keys(this.props.entity.kv).sort()

    return keys.map((k) => {
      const isOutput = _.find(this.props.entity.outputs, (o) => o.trigger === k)
      if (isOutput || k === 'classname') {
        return
      }
      const v = this.props.entity.kv[k]
      return (
        <tr>
          <th>{k}</th>
          <td>{v}</td>
        </tr>
      )
    })
  }

  render() {
    return (
      <div className="panel panel-default entity-info-panel">
        <div className="panel-body entity-info-panel-body">
          <Table bordered condensed hover >
            <tbody>{this.renderKeyValues()}</tbody>
          </Table>
        </div>
      </div>
    )
  }
}

