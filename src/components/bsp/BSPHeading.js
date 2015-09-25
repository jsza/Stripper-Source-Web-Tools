import React from 'react'
import {BSPActions} from '../../actions'


export default class BSPHeading extends React.Component {
  constructor(props) {
    super(props)
    this.onClickUnload = this.onClickUnload.bind(this)
  }

  onClickUnload(e) {
    e.preventDefault()
    BSPActions.flushStore()
  }

  render() {
    let subHeading
    if (this.props.fileName) {
      subHeading = (
        <small>
          {this.props.fileName} <a href="#" onClick={this.onClickUnload}>unload</a>
        </small>
      )
    }
    else {
      subHeading = ''
    }
    return (
      <h3>
        BSP Entity Viewer {subHeading}
      </h3>
    )
  }
}
