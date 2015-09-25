import routes from './routes'
import React from 'react'
import Router from 'react-router'


Router.run(routes,
  (Handler, state) =>
    React.render(<Handler params={state.params} />, document.getElementById('app'))
)
