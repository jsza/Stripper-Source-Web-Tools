Reflux = require('reflux')
{BSPActions} = require('../actions')
BSPStore = require('./BSPStore')



BSPErrorStore = Reflux.createStore
    listenables: [BSPActions]

    init: ->
        @listenTo(BSPStore, @onDismissError)


    getInitialState: ->
        @error = null
        return @error


    triggerUpdate: ->
        @trigger(@error)


    onError: (error) ->
        @error = error
        @triggerUpdate()


    onDismissError: ->
        @error = null
        @triggerUpdate()



module.exports = BSPErrorStore
