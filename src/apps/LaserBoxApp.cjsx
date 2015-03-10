React = require('react')
LinkedStateMixin = require('react/lib/LinkedStateMixin')
CoolInput = require('../components/CoolInput')
CodeMirror = require('codemirror')
Box = require('../utils/laser/Box')



LaserBoxApp = React.createClass
    mixins: [LinkedStateMixin]

    getInitialState: ->
        identifier: ''
        origin: ''
        size: ''
        width: ''
        color: ''
        texture: ''


    componentDidMount: ->
        @editor = CodeMirror.fromTextArea(@refs.editor.getDOMNode(), {
            readOnly: true
            lineNumbers: true
            theme: 'solarized dark'
        })


    getCode: ->
        box = new Box(@state.identifier, @state.origin, @state.size, @state.width,
                  @state.color, @state.texture)
        return box.renderStripperCode()


    onClickDoIt: ->
        @editor.setValue(@getCode())


    onClickReset: ->
        @setState({
            identifier: ''
            origin: ''
            size: ''
            width: ''
            color: ''
            texture: ''
        })
        @editor.setValue('')


    render: ->
        <div>
            <h3>Box</h3>
            <div className="row">
                <div className="col-lg-4">
                    <CoolInput title="Identifier" placeholder="unique identifier"
                        valueLink={@linkState('identifier')} />
                    <CoolInput title="Origin" placeholder="x y z"
                        valueLink={@linkState('origin')} />
                    <CoolInput title="Size" placeholder="x y z"
                        valueLink={@linkState('size')} />
                    <CoolInput title="Width" placeholder="4.0"
                        valueLink={@linkState('width')} />
                    <CoolInput title="Color" placeholder="255 0 0"
                        valueLink={@linkState('color')} />
                    <CoolInput
                        title="Texture"
                        placeholder="materials/effects/blueblacklargebeam.vmt"
                        defaultValue={@defaultTexture}
                        valueLink={@linkState('texture')} />

                    <button className="btn btn-default pull-left" onClick={@onClickReset}>Reset</button>
                    <button className="btn btn-default pull-right" onClick={@onClickDoIt}>Do it!</button>
                </div>
                <div className="col-lg-8">
                    <textarea ref="editor">
                    </textarea>
                </div>
            </div>
        </div>



module.exports = LaserBoxApp
