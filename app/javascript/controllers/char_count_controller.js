import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["textarea", "counter"];

  static classes = ["warning"];

  static values = {
    maxLength: { type: Number, default: 100 },
  }

  connect() {
    this.updateCount();
  }

  updateCount() {
    const currentLength = this.textareaTarget.value.length;
    this.counterTarget.textContent = `${currentLength} / ${this.maxLengthValue}`;

    if (currentLength >= this.maxLengthValue) {
      this.counterTarget.classList.add(this.warningClass);
    } else {
      this.counterTarget.classList.remove(this.warningClass);
    }
  }
}
