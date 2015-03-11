React = require('react')

{EntityFilterActions} = require('../../actions')



EntityClassnameFilter = React.createClass
    propTypes: {
        classnameTally: React.PropTypes.array.isRequired
    }


    componentWillUpdate: (nextProps, nextState) ->
        f = nextProps.classnameFilter
        if f != @props.classnameFilter and f != null
            @refs.select.getDOMNode().value = f


    onChange: (e) ->
        EntityFilterActions.setClassnameFilter(e.target.value)


    renderOptions: ->
        return @props.classnameTally.map((item) ->
            [cn, cnt] = item
            return <option value={cn}>{cn + ' (' + cnt + ')'}</option>
        )


    render: ->
        <select ref="select" className="form-control" name="select" defaultValue="all" onChange={@onChange}>
            <option value="all">All</option>
            {@renderOptions()}
        </select>



module.exports = EntityClassnameFilter
