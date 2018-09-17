import { baseURL } from "../config"
import createHttpClient from "../helpers/createHttpClient"

class IssueRepository {
  private httpClient: any

  constructor(httpClient: any) {
    this.httpClient = httpClient
  }

  public findAll(params: { user_id?: number; sort?: string; page?: number }) {
    return this.httpClient.get(`/issues`, {
      baseURL,
      params,
    })
  }

  public create(params: {
    subject: string
    description: string
    secret: boolean
  }) {
    return this.httpClient.post(`/issues`, params, {
      baseURL,
      headers: this.headers,
    })
  }

  public find({ id }: { id: number }) {
    return this.httpClient.get(`/issues/${id}`, {
      baseURL,
    })
  }

  public update({
    id,
    subject,
    description,
    secret,
  }: {
    id: number
    subject: string
    description: string
    secret: boolean
  }) {
    return this.httpClient.put(
      `/issues/${id}`,
      { subject, description, secret },
      {
        baseURL,
        headers: this.headers,
      }
    )
  }

  public delete({ id }: { id: number }) {
    return this.httpClient.delete(`/issues/${id}`, {
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

export default new IssueRepository(createHttpClient())
