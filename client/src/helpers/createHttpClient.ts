import axios from "axios"
import * as qs from "qs"

export default () => {
  const client = axios.create({
    paramsSerializer: (params: any) =>
      qs.stringify(params, { arrayFormat: "brackets" }),
    withCredentials: true,
  })

  client.interceptors.response.use(
    (res: any) => res,
    (resOrErr: any) => {
      if (resOrErr instanceof Error) {
        return Promise.reject(resOrErr)
      }

      return Promise.reject(
        new Error(
          `FETCH_ERROR(${
            resOrErr.status
          }): ${resOrErr.config.method.toUpperCase()} ${resOrErr.config.url}`
        )
      )
    }
  )

  return client
}
