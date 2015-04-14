Reflux = require('reflux')



BSPActions = Reflux.createActions([
    'loadBSP' # called when selecting a file in BSPDropzone
    'selectEntity'
    'setKeyValueFilter'
    'error'
    'dismissError'
    'flushStore'
])



EntityFilterActions = Reflux.createActions([
    'setClassnameFilter' # called by EntityClassnameFilter
    'setTextFilter'      # called by EntitySearch
])



module.exports = {BSPActions, EntityFilterActions}
