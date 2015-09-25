import React from 'react'
import Reflux from 'reflux'

import BSPStore from '../stores/BSPStore'

import {Row, Col} from 'react-bootstrap'

import EntityList from '../components/bsp/EntityList'
import ClassnameList from '../components/bsp/ClassnameList'
import EntityInfoPanel from '../components/bsp/EntityInfoPanel'
import BSPDropzone from '../components/bsp/BSPDropzone'
import BSPHeading from '../components/bsp/BSPHeading'
import BSPErrorPanel from '../components/bsp/BSPErrorPanel'
import ServerCommandWarning from '../components/bsp/ServerCommandWarning'
import {BSPActions} from '../actions'


export default React.createClass({
  mixins: [Reflux.connect(BSPStore)],

  handleFiles: function(files) {
    BSPActions.loadBSP(files[0])
  },

  render: function() {
    let content
    if (this.state.fileName) {
      content = (
        <BSPDropzone className="bsp-inner-container" noStyle handleFiles={this.handleFiles}>
          <EntityList {...this.state} />
          <EntityInfoPanel {...this.state} />
          <div className="bsp-starredlist-container" />
        </BSPDropzone>
      )
    }
    else {
      content = <BSPDropzone className="bsp-inner-container" handleFiles={this.handleFiles} />
    }
    return (
      <div className="inherit-height bsp-app-container">
        <BSPErrorPanel />
        <BSPHeading fileName={this.state.fileName} />
        {content}
        <ServerCommandWarning classnameTally={this.state.classnameTally} />
      </div>
    )
  }
})
