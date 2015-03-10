Reflux = require('reflux')



BSPActions = Reflux.createActions([
    'loadBSP' # called when selecting a file in BSPDropzone
    'selectEntity'
    'setKeyValueFilter'

    'dismissError'
])



module.exports = {BSPActions}
