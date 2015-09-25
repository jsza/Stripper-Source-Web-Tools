import React from 'react'

import BSPDropzone from '../components/bsp/BSPDropzone'
import {readEntities} from '../utils/bsp/Parser'


function findEntities(entities, targetname, notClasses) {
  let result = []
  if (targetname === undefined) {
    return result
  }
  for (let entity of entities) {
    const kv = entity.kv
    if (!notClasses.has(kv.classname)) {
      if ((kv.targetname !== undefined ? kv.targetname.toLowerCase() : null) === targetname.toLowerCase()) {
        result.push(entity)
      }
    }
  }
  return result
}


export default class CSGOFixesApp extends React.Component {
  constructor(props) {
    super(props)
    this.state = {maps: null}
  }

  handleFiles(files) {
    let ds = []
    let maps = {}
    const destClasses = new Set(['info_teleport_destination', 'info_target'])
    function foo(file) {
      return (entities) => {
        let convertDests = new Set()

        for (let entity of entities) {
          const kv = entity.kv
          if (destClasses.has(kv.classname)) {
            const conflicts = findEntities(entities, kv.targetname, destClasses)
            if (conflicts.length > 0) {
              convertDests.add([kv.targetname, conflicts])
            }
          }
        }
        maps[file.name] = convertDests
      }
    }
    for (var i = 0; i < files.length; i++) {
      const file = files[i]
      ds.push(readEntities(file)
        .then(foo(file))
      )
    }
    Promise.all(ds).then(() => this.setState({maps: maps}))
  }

  renderItems() {
    let result = []
    for (let k in this.state.maps) {
      const convertDests = this.state.maps[k]
      for (let [destName, conflicts] of convertDests) {
        console.log(destName)
        result.push(
          <div>
            <h3>{k}</h3>
            <textarea style={{display: 'block', width: '100%'}} rows="16">
{`; CS:GO targetname conflict fix
modify:
{
    match:
    {
        "classname" "/info_target|info_teleport_destination/"
        "targetname" "${destName}"
    }
    replace:
    {
        "targetname" "__${destName}"
    }
}
{
    match:
    {
        "classname" "trigger_teleport"
        "target" "${destName}"
    }
    replace:
    {
        "target" "__${destName}"
    }
}`}
            </textarea>
            <h4>Conflicts:</h4>
            <ul>
              {conflicts.map((x) =>
                <li>{x.kv.classname} :: {x.kv.targetname}</li>
              )}
            </ul>
          </div>
        )
      }
    }
    return result
  }

  render() {
    console.log(this.state.maps)
    if (this.state.maps) {
      return <div>{this.renderItems()}</div>
    }
    else {
      return <BSPDropzone handleFiles={this.handleFiles.bind(this)} />
    }
  }
}
