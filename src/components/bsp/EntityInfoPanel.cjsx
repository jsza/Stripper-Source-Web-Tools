React = require('react')
{TabbedArea, TabPane, Table} = require('react-bootstrap')
_ = require('underscore')

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
            return (
                <div className="bsp-info-container">
                    <div className="well" style={marginBottom: '10px', padding: '15px'}>
                        <h4 className="no-margin">
                            {title}
                            <span className="text-muted " style={fontWeight: 'normal'}>{subtitle}</span>
                            <span className="pull-right"><i className="fa fa-star-o" /></span>
                        </h4>
                    </div>
                    <TabbedArea animation={false} style={flex: '1 1 200px'}>
                        <TabPane eventKey={1} tab="Properties" disabled>
                            <EntityPropertiesPanel entity={@props.selectedEntity} />
                        </TabPane>
                        <TabPane eventKey={2} tab="Inputs">
                            <EntityInputsPanel entity={@props.selectedEntity} entities={@props.entities} />
                        </TabPane>
                        <TabPane eventKey={3} tab={'Outputs' + ' (' + @props.selectedEntity.outputs.length + ')'}>
                            <EntityOutputsPanel entity={@props.selectedEntity} />
                        </TabPane>
                        <TabPane eventKey={4} tab="Raw">
                            <EntityRawPanel entity={@props.selectedEntity} />
                        </TabPane>
                    </TabbedArea>
                </div>
            )
        return <div className="bsp-info-container" />



module.exports = EntityInfoPanel
