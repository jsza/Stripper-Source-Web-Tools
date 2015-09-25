import {objectToStripper} from '../keyvalues'


function mapToVector(s) {
  return s.split(' ').map(
    (thing) => parseFloat(thing)
  )
}


function makeBeam(targetname, start, end, width, color, texture) {
  return (
    { 'classname': 'env_beam'
    , 'targetname': targetname
    , 'BoltWidth': width
    , 'LightningStart': start
    , 'LightningEnd': end
    , 'rendercolor': color.join(' ')
    , 'texture': texture
    , 'origin': '0 0 0'
    , 'life': 0
    , 'spawnflags': '1'
    , 'StrikeTime': '0'
    , 'TextureScroll': 0
    })
}


function makeTarget(targetname, origin) {
  return (
    { 'classname': 'info_target'
    , 'targetname': targetname
    , 'origin': origin.join(' ')
    })
}


function addVectors(v1, v2) {
  return v1.map(
    (a, i) => a + v2[i])
}


export default class Box {
  constructor(identifier, origin, size, width, color, texture) {
    this.defaultWidth = 4.0
    this.defaultTexture = 'materials/effects/blueblacklargebeam.vmt'
    this.defaultColor = '255 0 0'
    this.identifier = identifier.trim()
    this.origin = mapToVector(origin.trim())
    this.size = mapToVector(size.trim())
    this.width = parseFloat((width || '').trim()) || this.defaultWidth
    this.color = mapToVector((color || this.defaultColor).trim())
    this.texture = (texture || this.defaultTexture).trim()
  }

  getCorners() {
    const x = this.size.map((i) => i/2)
    const s = {x: x[0], y: x[1], z: x[2]}

    return (
      { t1: addVectors(this.origin, [s.x,  s.y,  s.z])
      , t2: addVectors(this.origin, [-s.x, s.y,  s.z])
      , t3: addVectors(this.origin, [-s.x, -s.y, s.z])
      , t4: addVectors(this.origin, [s.x,  -s.y, s.z])
      , b1: addVectors(this.origin, [s.x,  s.y,  -s.z])
      , b2: addVectors(this.origin, [-s.x, s.y,  -s.z])
      , b3: addVectors(this.origin, [-s.x, -s.y, -s.z])
      , b4: addVectors(this.origin, [s.x,  -s.y, -s.z])
      })
  }

  renderStripperCode() {
    let result = []
    const c = this.getCorners()

    for (let k in c) {
      const v = c[k]
      result.push(makeTarget((this.identifier + k), v))
    }

    const b =
      [ ['t1', 't2'] //Top
      , ['t2', 't3']
      , ['t3', 't4']
      , ['t4', 't1']

      , ['b1', 'b2'] // Bottom
      , ['b2', 'b3']
      , ['b3', 'b4']
      , ['b4', 'b1']

      , ['t1', 'b1'] // Top to bottom
      , ['t2', 'b2']
      , ['t3', 'b3']
      , ['t4', 'b4']
      ]

    for (let [start, end] of b) {
      result.push(this.makeBeam(start, end))
    }

    return result.map(objectToStripper).join('\n')
  }

  makeBeam(start, end) {
    return makeBeam(
      (this.identifier + 'beam' + start + end), (this.identifier + start),
      (this.identifier + end), this.width, this.color,
      this.texture)
  }
}
