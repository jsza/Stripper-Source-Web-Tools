import React from 'react'
import {Nav} from 'react-bootstrap'
import {NavItemLink} from 'react-router-bootstrap'
import {RouteHandler} from 'react-router'


export default class EntityInfoPanel extends React.Component {
  render() {
    let content
    if (this.props.selectedEntity) {
      const kv = this.props.selectedEntity.kv
      const title = kv.classname
      let subtitle
      if (kv.targetname) {
        subtitle = ' - ' + kv.targetname
      }
      content = [
        <div className="well" style={{marginBottom: '10px', padding: '15px'}}>
          <h4 className="no-margin">
            {title}
            <span className="text-muted " style={{fontWeight: 'normal'}}>{subtitle}</span>
            <span className="pull-right"><i className="fa fa-star-o" /></span>
          </h4>
        </div>,
        <Nav bsStyle="tabs">
          <NavItemLink to="properties">Properties</NavItemLink>
          <NavItemLink to="inputs">Inputs ({this.props.selectedEntity.inputs.length})</NavItemLink>
          <NavItemLink to="outputs">Outputs ({this.props.selectedEntity.outputs.length})</NavItemLink>
          <NavItemLink to="raw">Raw</NavItemLink>
        </Nav>,
        <RouteHandler entity={this.props.selectedEntity} entities={this.props.entities} />
      ]
    }
    else {
      content = 'Select an entity.'
    }
    return <div className="bsp-info-container">{content}</div>
  }
}
