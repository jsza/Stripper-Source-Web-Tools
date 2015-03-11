React = require('react')
{ListGroup, ListGroupItem, Badge} = require('react-bootstrap')
{BSPActions} = require('../../actions')



ClassnameList = React.createClass
    onClickItem: (cn) ->
        BSPActions.setKeyValueFilter('classname', cn)


    renderItems: ->
        return @props.classnameTally.map((item) =>
            [cn, cnt] = item
            active = false
            if @props.kvFilter
                f = @props.kvFilter
                if f.key == 'classname' and item[0] == f.value
                    active = true
            return (
                <ListGroupItem
                        onClick={@onClickItem.bind(this, cn)} active={active}
                        key={cn} style={padding: '6px 12px', fontSize: '13px'} href="#">
                    <strong>{cn}</strong>
                    <span className="pull-right">{cnt}</span>
                </ListGroupItem>
            )
        )


    render: ->
        <div className="bsp-classlist-container">
            <div className="bsp-classname-list list-group">
                {@renderItems()}
            </div>
        </div>



module.exports = ClassnameList
