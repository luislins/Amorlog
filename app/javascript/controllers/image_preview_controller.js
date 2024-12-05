import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="image-preview"
export default class extends Controller {
  static targets = ["input", "previewContainer"];

  preview() {
    const fileInput = this.inputTarget;
    const previewContainer = this.previewContainerTarget;

    // Limpa qualquer pré-visualização existente
    previewContainer.innerHTML = "";

    if (fileInput.files && fileInput.files[0]) {
      const file = fileInput.files[0];

      // Garante que o arquivo é uma imagem
      if (!file.type.startsWith("image/")) {
        alert("Por favor, selecione um arquivo de imagem válido.");
        return;
      }

      const reader = new FileReader();
      reader.onload = (e) => {
        const img = document.createElement("img");
        img.src = e.target.result;
        img.alt = "Pré-visualização da imagem";
        img.className = "rounded-lg shadow-md max-w-full h-auto mt-2";
        previewContainer.appendChild(img);
      };
      reader.readAsDataURL(file);
    }
  }
}
