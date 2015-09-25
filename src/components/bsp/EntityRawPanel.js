import React from 'react'

import {objectToStripper} from '../../utils/keyvalues'
import {Panel} from 'react-bootstrap'


export default class RawEntityPanel extends React.Component {
  render() {
    return (
      <Panel className="entity-info-panel">
        <pre style={{marginBottom: 0}}>
        {objectToStripper(this.props.entity.kv)}
        </pre>
      </Panel>
    )
  }
}
