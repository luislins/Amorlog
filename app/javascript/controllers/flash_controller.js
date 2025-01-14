// app/javascript/controllers/flash_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { autoHide: Boolean, hideAfter: Number }

  connect() {
    if (this.autoHideValue) {
      this.timeout = setTimeout(() => this.close(), 5000);
    }
  }

  close() {
    this.element.style.transition = "opacity 0.5s ease";
    this.element.style.opacity = "0";
    setTimeout(() => this.element.remove(), 500); // Remove do DOM após animação
  }

  disconnect() {
    if (this.timeout) clearTimeout(this.timeout); // Limpa o timeout se o elemento for removido antes
  }
}
