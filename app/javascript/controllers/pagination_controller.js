import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

export default class extends Controller {
  static targets = ["lastPage"]

  static values = {
    url: String,
  };

  initialize() {
    this.scroll = this.scroll.bind(this);
    this.pageValue = 2;
    this.loading = false;
  }

  connect() {
    document.addEventListener("scroll", this.scroll);
  }

  disconnect() {
    document.removeEventListener("scroll", this.scroll);
  }

  scroll() {
    if (this.scrollReachedEnd && !this.hasLastPageTarget) {
      this._fetchNewPage()
    }
  }

  async _fetchNewPage() {
    if (this.loading) return;
    this.loading = true;

    const url = `${this.urlValue}?page=${this.pageValue}`;
    await get(url, {
        responseKind: "turbo-stream"
    });

    this.pageValue +=1;
    this.loading = false;
  }

  get scrollReachedEnd() {
    const { scrollHeight, scrollTop, clientHeight } = document.documentElement;
    const distanceFromBottom = scrollHeight - scrollTop - clientHeight;
    return distanceFromBottom < 500;
  }
}
