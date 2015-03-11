React = require('react')
Reflux = require('reflux')
{BSPActions} = require('../../actions')
cx = require('react/lib/cx')

EntityFilterStore = require('../../stores/EntityFilterStore')

EntitySearch = require('./EntitySearch')
EntityClassnameFilter = require('./EntityClassnameFilter')



EntityList = React.createClass
    mixins: [Reflux.connect(EntityFilterStore, 'filters')]

    onClickItem: (entity) ->
        BSPActions.selectEntity(entity)


    renderItems: ->
        entities = @props.entities
        filterClassname = @state.filters.classname
        filterText = @state.filters.text

        if filterClassname and filterClassname != 'all'
            entities = entities.filter((entity) ->
                return entity.kv.classname == filterClassname
            )

        if filterText
            entities = entities.filter((entity) ->
                for k, v of entity.kv
                    if k.indexOf(filterText) > -1
                        return true
                    if v.indexOf(filterText) > -1
                        return true
                return false
            )

        return entities.map((entity) =>
            classes = cx({
                'active': entity == @props.selectedEntity
            })
            <li className={classes} onClick={@onClickItem.bind(this, entity)}>
                {entity.kv.classname}
                {if entity.outputs.length then <i className="fa fa-toggle-right bsp-entity-list-icon" />}
            </li>
        )

    render: ->
        items = @renderItems()
        <div className="bsp-entitylist-container">
            <EntityClassnameFilter classnameTally={@props.classnameTally}
                                   classnameFilter={@state.filters.classname} />
            <span style={marginTop: '5px'}>
                <EntitySearch textFilter={@state.filters.text} />
            </span>
            <ul className="bsp-entity-list no-margin" style={marginTop: '5px'}>
                {items}
            </ul>
            <div className="well no-margin" style={marginTop: '5px', padding: '4px'}>
                <small className="text-muted">{items.length} result(s)</small>
            </div>
        </div>



module.exports = EntityList
