import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["textarea", "count"];

  connect() {
    this.maxLength = this.element.dataset.maxLength || 300;
    this.updateCount();
  }

  updateCount() {
    const currentLength = this.textareaTarget.value.length;
    this.countTarget.textContent = `${currentLength} / ${this.maxLength}`;

    if (currentLength >= this.maxLength) {
      this.countTarget.classList.add("text-red-500");
    } else {
      this.countTarget.classList.remove("text-red-500");
    }
  }
}
