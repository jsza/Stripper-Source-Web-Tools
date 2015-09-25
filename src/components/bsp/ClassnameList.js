import React from 'react'
import {ListGroupItem} from 'react-bootstrap'
import {BSPActions} from '../../actions'


export default class ClassnameList extends React.Component {
  onClickItem(cn) {
    BSPActions.setKeyValueFilter('classname', cn)
  }

  renderItems() {
    return this.props.classnameTally.map((item) => {
      const [cn, cnt] = item
      let active = false
      if (this.props.kvFilter) {
        const f = this.props.kvFilter
        if (f.key === 'classname' && item[0] === f.value) {
          active = true
        }
      }
      return (
        <ListGroupItem
            onClick={this.onClickItem.bind(this, cn)} active={active}
            key={cn} style={{padding: '6px 12px', fontSize: '13px'}} href="#">
          <strong>{cn}</strong>
          <span className="pull-right">{cnt}</span>
        </ListGroupItem>
      )
    })
  }

  render() {
    return (
      <div className="bsp-classlist-container">
        <div className="bsp-classname-list list-group">
          {this.renderItems()}
        </div>
      </div>
    )
  }
}
