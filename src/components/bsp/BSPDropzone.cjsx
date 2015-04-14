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

        # if files is empty, the user dropped something else into the page
        if not files.length
            return

        @handleFiles(files)

        @setState({
            dragActive: false
        })


    onClick: ->
        @refs.fileInput.getDOMNode().click()


    handleFiles: (files) ->
        @props.handleFiles(files)


    render: ->
        dropzoneClasses = cx({
            'bsp-dropzone': not @props.noStyle
            'active': @state.dragActive
        })
        if @props.noStyle
            return (
                <div className={@props.className + ' ' + dropzoneClasses} onDragLeave={@onDragLeave}
                     onDragOver={@onDragOver} onDrop={@onDrop}>
                    {@props.children}
                </div>
             )
        return (
            <div className={dropzoneClasses} onDragLeave={@onDragLeave}
                 onDragOver={@onDragOver} onDrop={@onDrop} onClick={@onClick}>
                <span className="bsp-dropzone-text">Drag file here or click</span>
                <input style={display: 'none'} type="file" multiple
                       ref="fileInput" onChange={this.onDrop} />
            </div>
        )



module.exports = BSPDropzone
