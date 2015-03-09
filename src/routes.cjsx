{Route, DefaultRoute} = require('react-router')
App = require('./App')
React = require('react')

BSPParserApp = require('./apps/BSPParserApp')
LaserBoxApp = require('./apps/LaserBoxApp')



NotFound = React.createClass
    render: ->
        <div>
            No matching route.
        </div>



module.exports = (
    <Route handler={App} path="/">
        <DefaultRoute handler={BSPParserApp}>
        </DefaultRoute>
        <Route name="bsp" handler={BSPParserApp} />
        <Route name="laser" handler={LaserBoxApp} />
    </Route>
)
