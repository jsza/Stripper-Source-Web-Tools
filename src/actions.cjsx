Reflux = require('reflux')



BSPActions = Reflux.createActions([
    'loadBSP' # called when selecting a file in BSPDropzone
    'selectEntity'
    'setKeyValueFilter'
    'error'
    'dismissError'
])



module.exports = {BSPActions}
