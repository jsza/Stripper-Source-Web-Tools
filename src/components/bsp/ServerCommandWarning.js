import React from 'react'

import {EntityFilterActions} from '../../actions'


export default class ServerCommandWarning extends React.Component {
  onClick(e) {
    e.preventDefault()
    EntityFilterActions.setClassnameFilter('point_servercommand')
  }

  render() {
    if (this.props.classnameTally) {
      for (let cn in this.props.classnameTally) {
        const cnt = this.props.classnameTally[cn]
        if (cn === 'point_servercommand') {
          return (
            <pre className="no-margin" style={{marginTop: '10px'}}>
              <span className="text-warning">
                WARNING: One or more <a href="#" onClick={this.onClick}>point_servercommand</a> detected. Be sure to check their inputs.
              </span>
            </pre>
          )
        }
      }
    }
    return null
  }
}
