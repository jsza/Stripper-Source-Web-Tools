import React from 'react'
import {Route, DefaultRoute} from 'react-router'
import App from './App'

import BSPParserApp from './apps/BSPParserApp'
import ServercommandApp from './apps/ServercommandApp'
import LaserBoxApp from './apps/LaserBoxApp'
import CSGOFixesApp from './apps/CSGOFixesApp'

import EntityPropertiesPanel from './components/bsp/EntityPropertiesPanel'
import EntityInputsPanel from './components/bsp/EntityInputsPanel'
import EntityOutputsPanel from './components/bsp/EntityOutputsPanel'
import EntityRawPanel from './components/bsp/EntityRawPanel'


class NotFound extends React.Component {
  render() {
    return (
      <div>
        No matching route.
      </div>
    )
  }
}


const routes = (
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
    <Route name="csgofixes" handler={CSGOFixesApp} />
  </Route>
)


export default routes
