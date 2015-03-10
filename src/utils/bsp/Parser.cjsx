{Promise} = require('es6-promise')



HEADER_LENGTH = 1036
IDENT_VBSP = 1347633750



parseEntity = (buf, pos) ->
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



parseEntities = (entityString) ->
    pos = 0
    entities = []
    while 1
        thing = parseEntity(entityString, pos)
        if thing is null
            break
        [entity, pos] = thing

        entities.push(entity)
    return entities



loadBSPHeader = (file, callback) ->
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
    return jBinary.load(file.slice(0, HEADER_LENGTH), typeSet, callback)



readEntities = (file) ->
    promise = new Promise((resolve, reject) ->
        loadBSPHeader(file, (error, binary) ->
            header = binary.read('dheader_t')
            if header.ident != IDENT_VBSP
                reject('"' + file.name + '" is not a valid BSP!')
            else
                entityLump = binary.read('lump_t')
                [ofs, len] = entityLump.fileofs

                reader = new FileReader()
                reader.onloadend = () =>
                    entityString = reader.result
                    resolve(parseEntities(reader.result))
                reader.readAsText(file.slice(ofs, ofs + len))
        )
    )
    return promise

    # thing = loadBSPHeader(file,
    #     (error, binary) ->
    #         header = binary.read('dheader_t')
    #         # console.log header.ident
    #         entityLump = binary.read('lump_t')
    # )

    # console.log thing

    # jBinary.load(file.slice(0, HEADER_LENGTH, typeSet,
    #     (error, data) =>
    #         data.read('dheader_t')
    #         thing = data.read('lump_t')
    #         [ofs, len] = thing.fileofs
    #         newFile = file.slice(ofs, ofs + len - 2)
    #         reader = new FileReader()
    #         reader.onloadend = () =>
    #             entityString = reader.result
    #             pos = 0

    #             entityCount = {}
    #             totalEntities = 0

    #             while 1
    #                 thing = readEntity(entityString, pos)
    #                 if thing is null
    #                     break
    #                 [entity, pos] = thing

    #                 if not entityCount[entity.classname]
    #                     entityCount[entity.classname] = 0

    #                 entityCount[entity.classname] += 1
    #                 totalEntities++

    #             @setState({
    #                 entityCount: entityCount
    #                 entityString: entityString
    #                 fileName: file.name
    #                 totalEntities: totalEntities
    #             })
    #         reader.readAsText(newFile)
    #     )



module.exports = {readEntities}
