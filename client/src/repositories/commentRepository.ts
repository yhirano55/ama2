import { baseURL } from "../config"
import createHttpClient from "../helpers/createHttpClient"

class CommentRepository {
  private httpClient: any

  constructor(httpClient: any) {
    this.httpClient = httpClient
  }

  public findAll(params: {
    issue_id?: number
    user_id?: number
    sort?: string
    page?: number
  }) {
    return this.httpClient.get(`/comments`, {
      baseURL,
      params,
    })
  }

  public create(params: {
    issue_id: number
    content: string
    secret: boolean
  }) {
    return this.httpClient.post(`/comments`, params, {
      baseURL,
      headers: this.headers,
    })
  }

  public find({ id }: { id: number }) {
    return this.httpClient.get(`/comments/${id}`, {
      baseURL,
    })
  }

  public update({
    id,
    issue_id,
    content,
    secret,
  }: {
    id: number
    issue_id: number
    content: string
    secret: boolean
  }) {
    return this.httpClient.update(
      `/comments/${id}`,
      { issue_id, content, secret },
      {
        baseURL,
        headers: this.headers,
      }
    )
  }

  public delete({ id }: { id: number }) {
    return this.httpClient.delete(`/comments/${id}`, {
      baseURL,
      headers: this.headers,
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

export default new CommentRepository(createHttpClient())
