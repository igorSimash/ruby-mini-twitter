import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  close(e) {
    const modal = document.getElementById("modal");
    modal.innerHTML = "";
    modal.removeAttribute("src");
    modal.removeAttribute("complete");
  }
}
