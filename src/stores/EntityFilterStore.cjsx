Reflux = require('reflux')

{EntityFilterActions} = require('../actions')



EntityFilterStore = Reflux.createStore
    listenables: [EntityFilterActions]

    getInitialState: ->
        @classnameFilter = null
        @textFilter = null
        return {
            text: @textFilter
            classname: @classnameFilter
        }


    triggerUpdate: ->
        @trigger({
            text: @textFilter
            classname: @classnameFilter
        })


    onSetClassnameFilter: (classname) ->
        @classnameFilter = classname
        @triggerUpdate()


    onSetTextFilter: (text) ->
        @textFilter = text
        @triggerUpdate()



module.exports = EntityFilterStore
