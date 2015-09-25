import React from 'react'

import {EntityFilterActions} from '../../actions'


export default class EntitySearch extends React.Component {
  constructor(props) {
    super(props)
    this.state = {value: null}
  }

  componentWillUpdate(nextProps, nextState) {
    const f = nextProps.textFilter
    if (f !== this.props.textFilter && f !== null) {
      this.refs.input.getDOMNode().value = f
    }
  }

  startTimeout() {
    this.triggerSearch()
    this.clearTimeout()
    this.timeoutID = window.setTimeout(this.triggerSearch, 0)
  }

  clearTimeout() {
    if (this.timeoutID) {
      window.clearTimeout(this.timeoutID)
      delete this.timeoutID
    }
  }

  triggerSearch() {
    EntityFilterActions.setTextFilter(this.state.value)
  }

  onChange(e) {
    this.setState({value: e.target.value})
    this.startTimeout()
  }


  render() {
    return <input ref="input"
                  className="form-control"
                  type="text"
                  onChange={this.onChange.bind(this)}
                  placeholder="Search entities" />
  }
}
