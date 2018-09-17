import * as React from "react"
import * as ReactDOM from "react-dom"
import App from "./containers/App"
import registerServiceWorker from "./registerServiceWorker"

import store, { history } from "./store"

import { ConnectedRouter } from "connected-react-router"
import { Provider } from "react-redux"
import { Route, Switch } from "react-router"

ReactDOM.render(
  <Provider store={store}>
    <ConnectedRouter history={history}>
      <div>
        <Switch>
          <Route exact path="/" render={() => <App />} />
          <Route render={() => <div>Miss</div>} />
        </Switch>
      </div>
    </ConnectedRouter>
  </Provider>,
  document.querySelector("#root") as HTMLElement
)
registerServiceWorker()
