_ = require('underscore')



objectToStripper = (object) ->
    result = ''
    _.keys(object).sort().forEach(
        (key) ->
            result += '    "' + key + '" "' + object[key] + '"\n'
    )
    return '{\n' + result + '}'



module.exports = {objectToStripper}
