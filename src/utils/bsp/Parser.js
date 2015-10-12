const HEADER_LENGTH = 1036
const IDENT_VBSP = 1347633750


function parseEntity(buf, pos) {
  let entity = {}

  let section = false
  let string = false
  let key = null

  let strBuf = ''

  let index = -1
  for (let c of buf.slice(pos)) {
    index++
    switch (c) {
      case '"':
        if (!section) {
          console.log('String in unopened section')
          return null
        }

        if (string) {
          if (key === null) {
            key = strBuf
            strBuf = ''
          }
          else {
            const value = strBuf
            entity[key] = value
            key = null
            strBuf = ''
          }
        }

        string = !string
        break
      case '{':
        section = true
        break
      case '}':
        return [entity, pos + index + 1]
      default:
        if (string) {
          strBuf = strBuf.concat(c)
        }
    }
  }

  return null
}


export function getEntityInputs(entity, entities) {
  let inputs = []
  if (entity.kv.targetname) {
    for (let e of entities) {
      e.outputs.forEach((output) => {
        if (output.parameters.includes('sv_airaccelerate')) {

          console.log(`${output.trigger} ${output.parameters}`)
        }
        if (output.target === entity.kv.targetname) {
          inputs.push({e: e, o: output})
        }
        // if (output.target.toLowerCase().trim() === entity.kv.classname) {
        //   console.log(output)
        // }
      })
    }
  }
  return inputs
}


function getEntityOutputs(entity) {
  let result = []
  for (let k in entity) {
    const v = entity[k]
    if (/^.*,.*,.*,.*,.*$/g.test(v)) {
      const foo = v.split(',')
      const [target, input, parameters, delay, onlyOnce] = v.split(',')
      result.push(
        { trigger: k
        , target: target
        , input: input
        , parameters: parameters
        , delay: delay
        , onlyOnce: onlyOnce
        })
    }
  }
  return result
}


function parseEntities(entityString) {
  let pos = 0
  let entities = []

  while (true) {
    const thing = parseEntity(entityString, pos)
    if (thing === null) {
      return entities.map(function(e) {
        return (
          { kv: e.kv
          , outputs: e.outputs
          , inputs: getEntityInputs(e, entities)
          })
      })
    }
    const entity = thing[0]
    pos = thing[1]
    const outputs = getEntityOutputs(entity)

    entities.push(
      { kv: entity
      , outputs: outputs
      })
  }
}


function loadBSPHeader(file, callback) {
  const typeSet =
    { 'jBinary.littleEndian': true
    , dheader_t:
      { ident: 'int32'
      , version: 'int32'
      }
    , lump_t:
      { fileofs: ['array', 'int32', 2]
      , version: 'int32'
      , fourCC: ['string', 4]
      }
    }
  return window.jBinary.load(file.slice(0, HEADER_LENGTH), typeSet, callback)
}


export function readEntities(file) {
  return new Promise(function(resolve, reject) {
    loadBSPHeader(file, function(error, binary) {
      const header = binary.read('dheader_t')
      if (header.ident != IDENT_VBSP) {
        reject('"' + file.name + '" is not a valid BSP!')
      }
      else {
        const entityLump = binary.read('lump_t')
        const [ofs, len] = entityLump.fileofs

        const reader = new FileReader()
        reader.onloadend = function() {
          const entityString = reader.result
          resolve(parseEntities(entityString))
        }
        reader.readAsText(file.slice(ofs, ofs + len))
      }
    })
  })
}
