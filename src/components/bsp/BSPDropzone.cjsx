React = require('react')
{BSPActions} = require('../../actions')
cx = require('react/lib/cx')



BSPDropzone = React.createClass
    getInitialState: ->
        {dragActive: false}


    onDragLeave: (e) ->
        @setState({
            dragActive: false
        })


    onDragOver: (e) ->
        e.preventDefault()
        e.dataTransfer.dropEffect = 'copy'

        @setState({
            dragActive: true
        })


    onDrop: (e) ->
        e.stopPropagation()
        e.preventDefault()

        if e.dataTransfer
            files = e.dataTransfer.files
        else if e.target
            files = e.target.files

        @handleFiles(files)

        @setState({
            dragActive: false
        })


    onClick: ->
        @refs.fileInput.getDOMNode().click()


    handleFiles: (files) ->
        BSPActions.loadBSP(files[0])


    render: ->
        dropzoneClasses = cx({
            'bsp-dropzone': true
            'active': @state.dragActive
        })
        <div>
            <div className={dropzoneClasses} onDragLeave={@onDragLeave}
                 onDragOver={@onDragOver} onDrop={@onDrop} onClick={@onClick}>
                <span className="bsp-dropzone-text">Drag file here or click</span>
            </div>
            <input style={display: 'none'} type="file" multiple
                   ref="fileInput" onChange={this.onDrop} />
        </div>



module.exports = BSPDropzone
