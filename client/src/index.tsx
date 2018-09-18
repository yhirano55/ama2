import * as React from "react"
import * as ReactDOM from "react-dom"
import registerServiceWorker from "./registerServiceWorker"

import Authentication from "./components/pages/Authentication"
import CommentList from "./components/pages/CommentList"
import EditComment from "./components/pages/EditComment"
import EditIssue from "./components/pages/EditIssue"
import IssueDetail from "./components/pages/IssueDetail"
import IssueList from "./components/pages/IssueList"
import NewIssue from "./components/pages/NewIssue"
import UserDetail from "./components/pages/UserDetail"
import UserList from "./components/pages/UserList"

import store, { history } from "./store"

import { ConnectedRouter } from "connected-react-router"
import { Provider } from "react-redux"
import { Route, Switch } from "react-router"

ReactDOM.render(
  <Provider store={store}>
    <ConnectedRouter history={history}>
      <Switch>
        <Route exact path="/" component={IssueList} />
        <Route exact path="/issues" component={IssueList} />
        <Route exact path="/issues/new" component={NewIssue} />
        <Route exact path="/issues/:id" component={IssueDetail} />
        <Route exact path="/issues/:id/edit" component={EditIssue} />
        <Route exact path="/comments" component={CommentList} />
        <Route exact path="/comments/:id/edit" component={EditComment} />
        <Route exact path="/users" component={UserList} />
        <Route exact path="/users/:id" component={UserDetail} />
        <Route exact path="/auth/github" component={Authentication} />
        <Route render={() => <div>NotFound</div>} />
      </Switch>
    </ConnectedRouter>
  </Provider>,
  document.querySelector("#root") as HTMLElement
)
registerServiceWorker()
