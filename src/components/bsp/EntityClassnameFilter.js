import React, {PropTypes as P} from 'react'

import {EntityFilterActions} from '../../actions'



export default class EntityClassnameFilter extends React.Component {
  componentWillUpdate(nextProps, nextState) {
    const f = nextProps.classnameFilter
    if (f !== this.props.classnameFilter && f !== null) {
      this.refs.select.getDOMNode().value = f
    }
  }

  onChange(e) {
    EntityFilterActions.setClassnameFilter(e.target.value)
  }

  renderOptions() {
    return this.props.classnameTally.map((item) => {
      const [cn, cnt] = item
      return <option value={cn}>{cn + ' (' + cnt + ')'}</option>
    })
  }

  render() {
    return (
      <select ref="select" className="form-control" name="select" defaultValue="all" onChange={this.onChange.bind(this)}>
        <option value="all">All</option>
        {this.renderOptions()}
      </select>
    )
  }
}


EntityClassnameFilter.propTypes =
  { classnameTally: P.array.isRequired
  }
