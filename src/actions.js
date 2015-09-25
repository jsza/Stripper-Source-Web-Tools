import Reflux from 'reflux'


export const BSPActions = Reflux.createActions(
  [ 'loadBSP'// called when selecting a file in BSPDropzone
  , 'selectEntity'
  , 'setKeyValueFilter'
  , 'error'
  , 'dismissError'
  , 'flushStore'
  ])


export const EntityFilterActions = Reflux.createActions(
  [ 'setClassnameFilter' // called by EntityClassnameFilter
  , 'setTextFilter'      // called by EntitySearch
  ])
