import React from 'react'

import {EntityFilterActions} from '../../actions'


export default class EntitySearch extends React.Component {
  constructor(props) {
    super(props)
  }

  onChange(e) {
    EntityFilterActions.setTextFilter(e.target.value)
  }

  render() {
    return <input ref="input"
                  className="form-control"
                  type="text"
                  onChange={this.onChange.bind(this)}
                  placeholder="Search entities"
                  value={this.props.textFilter} />
  }
}
