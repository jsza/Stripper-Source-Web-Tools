import React from 'react'
import Reflux from 'reflux'

import {Alert} from 'react-bootstrap'

import {BSPActions} from '../../actions'
import BSPErrorStore from '../../stores/BSPErrorStore'


export default React.createClass({
  mixins: [Reflux.connect(BSPErrorStore, 'error')],

  onDismiss: function() {
    BSPActions.dismissError()
  },

  render: function() {
    if (this.state.error) {
      return (
        <div>
          <br />
          <Alert bsStyle="danger" onDismiss={this.onDismiss}>
            <h4>Oh noes! An error!</h4>
            <p>{this.state.error}</p>
          </Alert>
        </div>
      )
    }
    else {
      return <div />
    }
  }
})
