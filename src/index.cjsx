React = require('react')
LaserBoxApp = require('./LaserBoxApp')



setInterval(
    ->
        React.render(<LaserBoxApp />, document.getElementById('laserBoxApp'))
    , 50)
