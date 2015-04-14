React = require('react')
{TabbedArea, TabPane, Table, Nav} = require('react-bootstrap')
{NavItemLink} = require('react-router-bootstrap')
_ = require('underscore')
{RouteHandler} = require('react-router')

EntityPropertiesPanel = require('./EntityPropertiesPanel')
EntityInputsPanel = require('./EntityInputsPanel')
EntityOutputsPanel = require('./EntityOutputsPanel')
EntityRawPanel = require('./EntityRawPanel')



EntityInfoPanel = React.createClass
    render: ->
        if @props.selectedEntity
            kv = @props.selectedEntity.kv
            title = kv.classname
            if kv.targetname
                subtitle = ' - ' + kv.targetname
            content = [
                <div className="well" style={marginBottom: '10px', padding: '15px'}>
                    <h4 className="no-margin">
                        {title}
                        <span className="text-muted " style={fontWeight: 'normal'}>{subtitle}</span>
                        <span className="pull-right"><i className="fa fa-star-o" /></span>
                    </h4>
                </div>
                <Nav bsStyle="tabs">
                    <NavItemLink to="properties">Properties</NavItemLink>
                    <NavItemLink to="inputs">Inputs ({@props.selectedEntity.inputs.length})</NavItemLink>
                    <NavItemLink to="outputs">Outputs ({@props.selectedEntity.outputs.length})</NavItemLink>
                    <NavItemLink to="raw">Raw</NavItemLink>
                </Nav>
                <RouteHandler entity={@props.selectedEntity} entities={@props.entities} />
                #<EntityPropertiesPanel entity={@props.selectedEntity} />
                #<TabbedArea className="wat" animation={false} style={flex: '1 1 200px'}>
                #    <TabPane eventKey={1} tab="Properties" disabled>
                #        <EntityPropertiesPanel entity={@props.selectedEntity} />
                #    </TabPane>
                #    <TabPane eventKey={2} tab="Inputs">
                #        <EntityInputsPanel entity={@props.selectedEntity} entities={@props.entities} />
                #    </TabPane>
                #    <TabPane eventKey={3} tab={'Outputs' + ' (' + @props.selectedEntity.outputs.length + ')'}>
                #        <EntityOutputsPanel entity={@props.selectedEntity} />
                #    </TabPane>
                #    <TabPane eventKey={4} tab="Raw">
                #        <EntityRawPanel entity={@props.selectedEntity} />
                #    </TabPane>
                #</TabbedArea>
            ]
        else
            content = 'Select an entity.'
        return <div className="bsp-info-container">{content}</div>



module.exports = EntityInfoPanel
