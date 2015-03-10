React = require('react')
{BSPActions} = require('../../actions')
cx = require('react/lib/cx')



EntityList = React.createClass
    onClickItem: (entity) ->
        BSPActions.selectEntity(entity)


    render: ->
        if @props.kvFilter
            f = @props.kvFilter
            entities = @props.entities.filter(
                (entity) ->
                    return entity[f.key] == f.value
            )
        else
            entities = @props.entities

        items = entities.map((entity) =>
            classes = cx({
                'active': entity == @props.selectedEntity
            })
            <li className={classes} onClick={@onClickItem.bind(this, entity)}>
                {entity.classname}
            </li>
        )
        <ul className="bsp-entity-list">
            {items}
        </ul>



module.exports = EntityList
