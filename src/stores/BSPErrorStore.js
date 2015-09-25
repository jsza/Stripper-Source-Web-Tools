import Reflux from 'reflux'
import {BSPActions} from '../actions'
import BSPStore from './BSPStore'


export default Reflux.createStore({
  listenables: [BSPActions],

  init: function() {
    this.listenTo(BSPStore, this.onDismissError)
  },

  getInitialState: function() {
    this.error = null
    return this.error
  },

  triggerUpdate: function() {
    this.trigger(this.error)
  },

  onError: function(error) {
    this.error = error
    this.triggerUpdate()
  },

  onDismissError: function() {
    this.error = null
    this.triggerUpdate()
  }
})
