import * as React from "react"
import { Route, Switch } from "react-router"

import Authentication from "./Authentication"
import CommentList from "./CommentList"
import EditComment from "./EditComment"
import EditIssue from "./EditIssue"
import IssueDetail from "./IssueDetail"
import IssueList from "./IssueList"
import NewIssue from "./NewIssue"
import UserDetail from "./UserDetail"
import UserList from "./UserList"

class App extends React.Component {
  public render() {
    return (
      <div>
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
      </div>
    )
  }
}

export default App
