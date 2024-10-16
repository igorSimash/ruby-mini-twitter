import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  close(e) {
    const modal = this.element;

    modal.parentElement.removeAttribute("src")
    modal.remove();
  }
}
