Reflux = require('reflux')
{BSPActions} = require('../actions')
{readEntities} = require('../utils/bsp/Parser')
_ = require('underscore')



BSPStore = Reflux.createStore
    listenables: [BSPActions]

    getInitialState: ->
        @loading = false
        @fileName = null
        @entities = null
        @classnameTally = null
        @selectedEntity = null
        @kvFilter = null
        return {
            loading: @loading
            fileName: @fileName
            entities: @entities
            classnameTally: @classnameTally
            selectedEntity: @selectedEntity
            kvFilter: @kvFilter
        }


    triggerUpdate: ->
        @trigger({
            loading: @loading
            fileName: @fileName
            entities: @entities
            classnameTally: @classnameTally
            selectedEntity: @selectedEntity
            kvFilter: @kvFilter
        })


    countClassnames: ->
        thing = {}
        for entity in @entities
            cn = entity.classname
            if not thing[cn]
                thing[cn] = 0
            thing[cn]++
        @classnameTally = _.pairs(thing).sort()


    onLoadBSP: (file) ->
        @loading = true
        @triggerUpdate()
        readEntities(file)
            .then(
                (entities) =>
                    entities.sort((a, b) ->
                        if a.classname > b.classname
                            return 1
                        if a.classname < b.classname
                            return -1
                        return 0
                    )
                    @fileName = file.name
                    @entities = entities
                    @countClassnames()
                    @loading = false
                    setTimeout(@triggerUpdate, 0)
                ,
                (error) ->
                    BSPActions.error(error)
                    @loading = false
                    setTimeout(@triggerUpdate, 0)
            )


    onSelectEntity: (entity) ->
        @selectedEntity = entity
        @triggerUpdate()


    onSetKeyValueFilter: (key, value) ->
        @kvFilter = {key: key, value: value}
        @triggerUpdate()



module.exports = BSPStore