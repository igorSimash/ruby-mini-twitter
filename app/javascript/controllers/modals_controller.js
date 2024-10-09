import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  close(e) {
    if (e.type === "turbo:submit-end" && !e.detail.success) return;

    const modal = document.getElementById("modal");
    modal.innerHTML = "";
    modal.removeAttribute("src");
    modal.removeAttribute("complete");
  }
}
