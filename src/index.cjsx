# React = require('react')
# LaserBoxApp = require('./LaserBoxApp')
# BSPParserApp = require('./BSPParserApp')



routes = require('./routes')
React = require('react')
Router = require('react-router')



Router.run(routes,
    (Handler, state) ->
        React.render(<Handler params={state.params} />, document.getElementById('app'))
)




# setInterval(
#     ->
#         React.render(<LaserBoxApp />, document.getElementById('laserBoxApp'))
#         React.render(<BSPParserApp />, document.getElementById('bspParserApp'))
#     , 50)
