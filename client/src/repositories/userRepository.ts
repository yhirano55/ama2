import { baseURL } from "../config"
import createHttpClient from "../helpers/createHttpClient"

class UserRepository {
  private httpClient: any

  constructor(httpClient: any) {
    this.httpClient = httpClient
  }

  public findAll(params: { page?: number }) {
    return this.httpClient.get(`/users`, {
      baseURL,
      params,
    })
  }

  public find({ id }: { id: number }) {
    return this.httpClient.get(`/users/${id}`, {
      baseURL,
    })
  }
}

export default new UserRepository(createHttpClient())
