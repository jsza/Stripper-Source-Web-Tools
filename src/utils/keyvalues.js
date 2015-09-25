import _ from 'underscore'


export function objectToStripper(object) {
  let result = ''
  _.keys(object).sort().forEach(
    (key) =>
      result += '    "' + key + '" "' + object[key] + '"\n'
  )
  return '{\n' + result + '}'
}
