Reflux = require('reflux')

{EntityFilterActions, BSPActions} = require('../actions')



EntityFilterStore = Reflux.createStore
    listenables: [EntityFilterActions, BSPActions]

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


    onFlushStore: ->
        @classnameFilter = null
        @textFilter = null
        @triggerUpdate()


    onSetClassnameFilter: (classname) ->
        @classnameFilter = classname
        @triggerUpdate()


    onSetTextFilter: (text) ->
        @textFilter = text
        @triggerUpdate()



module.exports = EntityFilterStore
