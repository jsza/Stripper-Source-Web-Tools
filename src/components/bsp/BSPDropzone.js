import React from 'react'
import cx from 'react/lib/cx'


export default class BSPDropzone extends React.Component {
  constructor(props) {
    super(props)
    this.state = {dragActive: false}
    this.onDragLeave = this.onDragLeave.bind(this)
    this.onDragOver = this.onDragOver.bind(this)
    this.onDrop = this.onDrop.bind(this)
    this.onClick = this.onClick.bind(this)
  }

  onDragLeave(e) {
    this.setState({
      dragActive: false
    })
  }

  onDragOver(e) {
    e.preventDefault()
    e.dataTransfer.dropEffect = 'copy'

    this.setState({
      dragActive: true
    })
  }

  onDrop(e) {
    e.stopPropagation()
    e.preventDefault()

    let files
    if (e.dataTransfer) {
      files = e.dataTransfer.files
    }
    else if (e.target) {
      files = e.target.files
    }

    // if files is empty, the user dropped something else into the page
    if (!files.length) {
      return
    }

    this.handleFiles(files)

    this.setState({
      dragActive: false
    })
  }

  onClick() {
    this.refs.fileInput.getDOMNode().click()
  }

  handleFiles(files) {
    this.props.handleFiles(files)
  }

  render() {
    const dropzoneClasses = cx(
      { 'bsp-dropzone': !this.props.noStyle
      , 'active': this.state.dragActive
      })
    if (this.props.noStyle) {
      return (
        <div className={this.props.className + ' ' + dropzoneClasses} onDragLeave={this.onDragLeave}
           onDragOver={this.onDragOver} onDrop={this.onDrop}>
          {this.props.children}
        </div>
       )
    }
    return (
      <div className={dropzoneClasses} onDragLeave={this.onDragLeave}
         onDragOver={this.onDragOver} onDrop={this.onDrop} onClick={this.onClick}>
        <span className="bsp-dropzone-text">Drag file here or click</span>
        <input style={{display: 'none'}} type="file" multiple
             ref="fileInput" onChange={this.onDrop} />
      </div>
    )
  }
}
