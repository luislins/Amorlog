import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "previewContainer"];

  files = []; // Armazena os novos arquivos selecionados

  connect() {
    // Preserva as imagens carregadas do servidor (se aplicável)
    const existingImages = Array.from(this.previewContainerTarget.querySelectorAll("[data-image-id]"));
    existingImages.forEach((image) => {
      this.files.push({ id: image.dataset.imageId, existing: true });
    });
  }

  preview() {
    const input = this.inputTarget;
    const container = this.previewContainerTarget;

    // Adiciona novos arquivos à lista
    const newFiles = Array.from(input.files).map((file) => ({ file, existing: false }));
    this.files = [...this.files, ...newFiles];

    // Atualize o campo input com os novos arquivos
    const dataTransfer = new DataTransfer();
    this.files.forEach((fileObj) => {
      if (!fileObj.existing) dataTransfer.items.add(fileObj.file);
    });
    input.files = dataTransfer.files;

    // Renderiza todas as imagens (novas e salvas)
    this.renderPreview(container);
  }

  remove(event) {
    const container = this.previewContainerTarget;
    const index = event.currentTarget.dataset.index;

    // Remove o arquivo do array
    this.files.splice(index, 1);

    // Atualize o campo input com os arquivos restantes
    const dataTransfer = new DataTransfer();
    this.files.forEach((fileObj) => {
      if (!fileObj.existing) dataTransfer.items.add(fileObj.file);
    });
    this.inputTarget.files = dataTransfer.files;

    // Re-renderize as pré-visualizações
    this.renderPreview(container);
  }

  renderPreview(container) {
    container.innerHTML = ""; // Limpa pré-visualizações antigas
    this.files.forEach((fileObj, index) => {
      const wrapper = document.createElement("div");
      wrapper.classList.add("relative");

      if (fileObj.existing) {
        // Imagem já salva no servidor
        const img = document.createElement("img");
        img.src = fileObj.file || `/rails/active_storage/blobs/${fileObj.id}`; // Ajuste a URL conforme necessário
        img.classList.add("rounded-lg", "shadow-md", "w-full", "h-40", "object-cover", "mb-2");
        wrapper.appendChild(img);
      } else {
        // Imagem nova selecionada pelo usuário
        const reader = new FileReader();
        reader.onload = (event) => {
          const img = document.createElement("img");
          img.src = event.target.result;
          img.classList.add("rounded-lg", "shadow-md", "w-full", "h-40", "object-cover", "mb-2");
          wrapper.appendChild(img);
        };
        reader.readAsDataURL(fileObj.file);
      }

      // Botão de remoção
      const removeButton = document.createElement("button");
      removeButton.type = "button";
      removeButton.textContent = "Remover";
      removeButton.classList.add("absolute", "top-2", "right-2", "bg-red-600", "text-white", "px-2", "py-1", "rounded-full", "text-xs", "hover:bg-red-800", "transition-all");
      removeButton.dataset.index = index;
      removeButton.addEventListener("click", (event) => this.remove(event));

      wrapper.appendChild(removeButton);
      container.appendChild(wrapper);
    });
  }
}
