import React from 'react'
import Reflux from 'reflux'
import {BSPActions} from '../../actions'
import cx from 'react/lib/cx'

import EntityFilterStore from '../../stores/EntityFilterStore'

import EntitySearch from './EntitySearch'
import EntityClassnameFilter from './EntityClassnameFilter'



export default React.createClass({
  mixins: [Reflux.connect(EntityFilterStore, 'filters')],

  onClickItem: function(entity) {
    BSPActions.selectEntity(entity)
  },

  renderItems: function() {
    let entities = this.props.entities
    const filterClassname = this.state.filters.classname
    const filterText = this.state.filters.text

    if (filterClassname && filterClassname !== 'all') {
      entities = entities.filter((entity) =>
        entity.kv.classname === filterClassname
      )
    }

    if (filterText) {
      entities = entities.filter((entity) => {
        for (let k in entity.kv) {
          const v = entity.kv[k]
          if (k.indexOf(filterText) > -1) {
            return true
          }
          else if (v.indexOf(filterText) > -1) {
            return true
          }
        }
        return false
      })
    }

    return entities.map((entity) => {
      const classes = cx({
        'active': entity === this.props.selectedEntity
      })
      let symbols = []
      if (entity.inputs.length) {
        symbols.push('I')
      }
      if (entity.outputs.length) {
        symbols.push('O')
      }
      const icons = symbols.join(' + ')
      return (
        <li className={classes} onClick={this.onClickItem.bind(this, entity)}>
          {entity.kv.classname}
          <span className="pull-right">
            {icons}
          </span>
        </li>
      )
    })
  },

  render: function() {
    const items = this.renderItems()
    return (
      <div className="bsp-entitylist-container">
        <EntityClassnameFilter classnameTally={this.props.classnameTally}
                     classnameFilter={this.state.filters.classname} />
        <span style={{marginTop: '5px'}}>
          <EntitySearch textFilter={this.state.filters.text} />
        </span>
        <ul className="bsp-entity-list no-margin" style={{marginTop: '5px'}}>
          {items}
        </ul>
        <div className="well no-margin" style={{marginTop: '5px', padding: '4px'}}>
          <small className="text-muted">{items.length} result(s)</small>
        </div>
      </div>
    )
  }
})
