import React from 'react'
import LinkedStateMixin from 'react/lib/LinkedStateMixin'
import CoolInput from '../components/CoolInput'
import CodeMirror from 'codemirror'
import Box from '../utils/laser/Box'


export default React.createClass({
  mixins: [LinkedStateMixin],

  getInitialState: function() {
    return (
      { identifier: ''
      , origin: ''
      , size: ''
      , width: ''
      , color: ''
      , texture: ''
      })
  },

  componentDidMount: function() {
    this.editor = CodeMirror.fromTextArea(this.refs.editor.getDOMNode(),
      { readOnly: true
      , lineNumbers: true
      , theme: 'solarized dark'
      })
  },

  getCode: function() {
    const box = new Box(this.state.identifier, this.state.origin,
                        this.state.size, this.state.width, this.state.color,
                        this.state.texture)
    return box.renderStripperCode()
  },

  onClickDoIt: function() {
    this.editor.setValue(this.getCode())
  },

  onClickReset: function() {
    this.setState(
      { identifier: ''
      , origin: ''
      , size: ''
      , width: ''
      , color: ''
      , texture: ''
      })
    this.editor.setValue('')
  },

  render: function() {
    return (
      <div>
        <h3>Box</h3>
        <div className="row">
          <div className="col-lg-4">
            <CoolInput title="Identifier" placeholder="unique identifier"
              valueLink={this.linkState('identifier')} />
            <CoolInput title="Origin" placeholder="x y z"
              valueLink={this.linkState('origin')} />
            <CoolInput title="Size" placeholder="x y z"
              valueLink={this.linkState('size')} />
            <CoolInput title="Width" placeholder="4.0"
              valueLink={this.linkState('width')} />
            <CoolInput title="Color" placeholder="255 0 0"
              valueLink={this.linkState('color')} />
            <CoolInput
              title="Texture"
              placeholder="materials/effects/blueblacklargebeam.vmt"
              defaultValue={this.defaultTexture}
              valueLink={this.linkState('texture')} />

            <button className="btn btn-default pull-left" onClick={this.onClickReset}>Reset</button>
            <button className="btn btn-default pull-right" onClick={this.onClickDoIt}>Do it!</button>
          </div>
          <div className="col-lg-8">
            <textarea ref="editor">
            </textarea>
          </div>
        </div>
      </div>
    )
  }
})
