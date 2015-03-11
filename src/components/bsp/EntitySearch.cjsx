React = require('react')

{EntityFilterActions} = require('../../actions')



EntitySearch = React.createClass
    componentWillUpdate: (nextProps, nextState) ->
        f = nextProps.textFilter
        if f != @props.textFilter and f != null
            @refs.input.getDOMNode().value = f


    getInitialState: ->
        value: null


    startTimeout: ->
        @triggerSearch()
        @clearTimeout()
        @timeoutID = window.setTimeout(@triggerSearch, 0)


    clearTimeout: ->
        if @timeoutID
            window.clearTimeout(@timeoutID)
            delete @timeoutID


    triggerSearch: ->
        EntityFilterActions.setTextFilter(@state.value)


    onChange: (e) ->
        @setState({value: e.target.value})
        @startTimeout()


    render: ->
        <input ref="input" className="form-control" type="text" onChange={@onChange} placeholder="Search entities" />



module.exports = EntitySearch
