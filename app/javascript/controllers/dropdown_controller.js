import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"];

  static classes = ["hide"];

  connect() {
    document.addEventListener("click", this.outsideClose.bind(this))
  }

  disconnect() {
    document.removeEventListener("click", this.outsideClose.bind(this))
  }

  toggle(event) {
    event.preventDefault();

    this.menuTarget.classList.toggle(this.hideClass)
  }

  outsideClose(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add(this.hideClass)
    }
  }
}
