class CurrentUser {
  private storage: Storage

  constructor(storage: Storage) {
    this.storage = storage
  }

  public get nickname(): string | null {
    return this.storage.getItem("nickname")
  }

  public get avatarUrl(): string | null {
    return this.storage.getItem("avatarUrl")
  }

  public get accessToken(): string | null {
    return this.storage.getItem("accessToken")
  }

  public isLoggedIn() {
    return this.nickname && this.avatarUrl && this.accessToken
  }
}

export default new CurrentUser(window.sessionStorage)
