import * as React from "react"

import { storiesOf } from "@storybook/react"
// import { action } from '@storybook/addon-actions'
// import { linkTo } from '@storybook/addon-links'

import Sample from "../components/Sample"

storiesOf("Sample", module).add("default", () => <Sample message="world" />)
