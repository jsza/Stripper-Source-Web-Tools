React = require('react')
# ctype = require('ctype')
cx = require('react/lib/cx')



BSPParserApp = React.createClass
    getInitialState: ->
        {
            entityString: null
            dragActive: false
        }


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


    handleFiles: (files) ->
        file = files[0]
        initialFile = file.slice(0, 400)

        typeSet = {
            'jBinary.littleEndian': true
            dheader_t: {
                ident: 'int32'
                version: 'int32'
            }
            lump_t: {
                fileofs: ['array', 'int32', 2]
                version: 'int32'
                fourCC: ['string', 4]
            }
        }

        readEntity = (buf, pos) ->
            entity = {}

            section = false
            string = false
            key = null

            strBuf = ''

            for c, index in buf.slice(pos)
                switch c
                    when '"'
                        if not section
                            console.log('String in unopened section')
                            return

                        if string
                            if key == null
                                key = strBuf
                                strBuf = ''
                            else
                                value = strBuf
                                entity[key] = value
                                key = null
                                strBuf = ''

                        string = not string
                    when '{'
                        section = true
                    when '}'
                        return [entity, pos + index + 1]
                    else
                        if string
                            strBuf = strBuf.concat(c)

            return null

        jBinary.load(initialFile, typeSet,
            (error, data) =>
                data.read('dheader_t')
                thing = data.read('lump_t')
                [ofs, len] = thing.fileofs
                newFile = file.slice(ofs, ofs + len - 2)
                reader = new FileReader()
                reader.onloadend = () =>
                    entityString = reader.result
                    pos = 0

                    entityCount = {}

                    while 1
                        thing = readEntity(entityString, pos)
                        if thing is null
                            break
                        [entity, pos] = thing

                        if not entityCount[entity.classname]
                            entityCount[entity.classname] = 0

                        entityCount[entity.classname] += 1

                    @setState({
                        entityCount: entityCount
                        entityString: entityString
                        fileName: file.name
                    })
                reader.readAsText(newFile)
            )


    onClickDropzone: ->
        @refs.fileInput.getDOMNode().click()


    render: ->
        dropzoneClasses = cx({
            'bsp-dropzone': true
            'active': @state.dragActive
        })
        if @state.entityCount
            items = []
            for k, v of @state.entityCount
                items.push(
                    <a className={"list-group-item" + (if k == 'worldspawn' then ' active' else '')}>
                        <span className="badge">{v}</span>
                        {k}
                    </a>
                )
            content = (
                <div className="row">
                    <div className="col-lg-2">
                        <div className="list-group">{items}</div>
                    </div>
                    <div className="col-lg-8">
                        <div className={dropzoneClasses} onDragLeave={@onDragLeave}
                             onDragOver={@onDragOver} onDrop={@onDrop}>
                             <span className="bsp-dropzone-text">Drag file here or click!</span>
                        </div>
                    </div>
                </div>
            )
        else
            content = (
                <div className={dropzoneClasses} onDragLeave={@onDragLeave}
                     onDragOver={@onDragOver} onDrop={@onDrop} onClick={@onClickDropzone}>
                     <span className="bsp-dropzone-text">Drag file here or click</span>
                </div>
            )
        <div>
            <h3>BSP Entity Viewer <small>{@state.fileName}</small></h3>
             <input style={display: 'none'} type="file" multiple
                    ref="fileInput" onChange={this.onDrop} />
            {content}
        </div>



module.exports = BSPParserApp
