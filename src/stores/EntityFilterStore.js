import Reflux from 'reflux'

import {EntityFilterActions, BSPActions} from '../actions'


export default Reflux.createStore({
  listenables: [EntityFilterActions, BSPActions],

  getInitialState: function () {
    this.classnameFilter = null
    this.textFilter = null
    return (
      { text: this.textFilter
      , classname: this.classnameFilter
      })
  },

  triggerUpdate: function() {
    this.trigger(
      { text: this.textFilter
      , classname: this.classnameFilter
      })
  },

  onFlushStore: function() {
    this.classnameFilter = null
    this.textFilter = null
    this.triggerUpdate()
  },

  onSetClassnameFilter: function(classname) {
    this.classnameFilter = classname
    this.triggerUpdate()
  },

  onSetTextFilter: function(text) {
    this.textFilter = text
    this.triggerUpdate()
  }
})
