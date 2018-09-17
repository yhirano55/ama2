import { baseURL } from "../config"
import createHttpClient from "../helpers/createHttpClient"

class LikeRepository {
  private httpClient: any

  constructor(httpClient: any) {
    this.httpClient = httpClient
  }

  public create(params: { type: string; resource_id: number }) {
    return this.httpClient.post(`/like`, params, {
      baseURL,
      headers: this.headers,
    })
  }

  public delete(params: { type: string; resource_id: number }) {
    return this.httpClient.delete(`/like`, {
      baseURL,
      headers: this.headers,
      params,
    })
  }

  private get headers() {
    return {
      Authorization: `Bearer ${this.accessToken}`,
    }
  }

  private get accessToken() {
    return "accessToken"
  }
}

export default new LikeRepository(createHttpClient())
