import { connectRouter, routerMiddleware } from "connected-react-router"
import { createBrowserHistory } from "history"
import { applyMiddleware, compose, createStore } from "redux"
import { createLogger } from "redux-logger"

import reducers from "../reducers"

export const history = createBrowserHistory()
const middlewares = []

if (process.env.NODE_ENV === "development") {
  const logger = createLogger()
  middlewares.push(logger)
}

middlewares.push(routerMiddleware(history))

const store = createStore(
  connectRouter(history)(reducers),
  {},
  compose(applyMiddleware(...middlewares))
)

export default store
