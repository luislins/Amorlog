import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "previewContainer"];

  preview() {
    const input = this.inputTarget;
    const container = this.previewContainerTarget;

    // Limpa pré-visualizações antigas
    container.innerHTML = "";

    Array.from(input.files).forEach(file => {
      const reader = new FileReader();
      reader.onload = event => {
        const img = document.createElement("img");
        img.src = event.target.result;
        img.classList.add("rounded-lg", "shadow-md", "w-full", "h-40", "object-cover", "mb-2");
        container.appendChild(img);
      };
      reader.readAsDataURL(file);
    });
  }
}
