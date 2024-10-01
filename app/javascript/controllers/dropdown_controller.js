import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    document.addEventListener("click", this.outsideClose.bind(this))
  }

  disconnect() {
    document.removeEventListener("click", this.outsideClose.bind(this))
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }

  outsideClose(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
    }
  }
}
