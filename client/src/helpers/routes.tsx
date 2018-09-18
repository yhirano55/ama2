import * as React from "react"
import { Redirect, Route } from "react-router-dom"

import currentUser from "./currentUser"

export const AuthenticatedRoute = ({ component: Component, ...rest }: any) => (
  <Route
    {...rest}
    render={props =>
      currentUser.isLoggedIn() ? <Component {...props} /> : <Redirect to="/" />
    }
  />
)

export const UnauthenticatedRoute = ({
  component: Component,
  ...rest
}: any) => (
  <Route
    {...rest}
    render={props =>
      !currentUser.isLoggedIn() ? <Component {...props} /> : <Redirect to="/" />
    }
  />
)
