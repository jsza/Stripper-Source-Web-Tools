import Reflux from 'reflux'
import {BSPActions} from '../actions'
import {readEntities} from '../utils/bsp/Parser'
import _ from 'underscore'


export default Reflux.createStore({
  listenables: [BSPActions],

  getInitialState: function() {
    this.loading = false
    this.fileName = null
    this.entities = null
    this.classnameTally = null
    this.selectedEntity = null
    return (
      { loading: this.loading
      , fileName: this.fileName
      , entities: this.entities
      , classnameTally: this.classnameTally
      , selectedEntity: this.selectedEntity
      })
  },

  triggerUpdate: function() {
    this.trigger(
      { loading: this.loading
      , fileName: this.fileName
      , entities: this.entities
      , classnameTally: this.classnameTally
      , selectedEntity: this.selectedEntity
      })
  },


  countClassnames: function() {
    let thing = {}
    for (let entity of this.entities) {
      const cn = entity.kv.classname
      if (!thing[cn]) {
        thing[cn] = 0
      }
      thing[cn]++
    }
    this.classnameTally = _.pairs(thing).sort()
  },

  onFlushStore: function() {
    this.fileName = null
    this.entities = null
    this.classnameTally = null
    this.selectedEntity = null
    this.triggerUpdate()
  },

  onLoadBSP: function(file) {
    BSPActions.flushStore()
    this.loading = true
    this.triggerUpdate()
    const _self = this
    readEntities(file)
      .then(
        function(entities) {
          entities.sort((a, b) => {
            if (a.kv.classname > b.kv.classname) {
              return 1
            }
            else if (a.kv.classname < b.kv.classname) {
              return -1
            }
            return 0
          })
          _self.fileName = file.name
          _self.entities = entities
          _self.countClassnames()
          _self.loading = false
          setTimeout(_self.triggerUpdate, 0)
        },
        function(error) {
          BSPActions.error(error)
          _self.loading = false
          setTimeout(_self.triggerUpdate, 0)
        }
      )
  },

  onSelectEntity: function(entity) {
    this.selectedEntity = entity
    this.triggerUpdate()
  },

  onSetKeyValueFilter: function (key, value) {
    this.kvFilter = {key: key, value: value}
    this.triggerUpdate()
  }
})
