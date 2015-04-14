{Route, DefaultRoute} = require('react-router')
App = require('./App')
React = require('react')

BSPParserApp = require('./apps/BSPParserApp')
ServercommandApp = require('./apps/ServercommandApp')
LaserBoxApp = require('./apps/LaserBoxApp')

EntityPropertiesPanel = require('./components/bsp/EntityPropertiesPanel')
EntityInputsPanel = require('./components/bsp/EntityInputsPanel')
EntityOutputsPanel = require('./components/bsp/EntityOutputsPanel')
EntityRawPanel = require('./components/bsp/EntityRawPanel')



NotFound = React.createClass
    render: ->
        <div>
            No matching route.
        </div>



module.exports = (
    <Route handler={App} path="/">
        <DefaultRoute handler={BSPParserApp}>
        </DefaultRoute>
        <Route name="bsp" handler={BSPParserApp}>
            <Route name="properties" handler={EntityPropertiesPanel} />
            <Route name="inputs"     handler={EntityInputsPanel} />
            <Route name="outputs"    handler={EntityOutputsPanel} />
            <Route name="raw"        handler={EntityRawPanel} />
        </Route>
        <Route name="servercommand" handler={ServercommandApp} />
        <Route name="laser" handler={LaserBoxApp} />
    </Route>
)
