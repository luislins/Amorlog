import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "form", "currentValueField"];

  open(event) {
    // Obtém o ID do goal a partir do botão clicado
    const goalId = event.currentTarget.dataset.goalId;

    // Configura a URL do formulário com o ID correto
    this.formTarget.action = event.currentTarget.dataset.baseUrl.replace(":id", goalId);

    // Carrega o valor atual do current_value no campo numérico
    const currentValue = event.currentTarget.dataset.currentValue;
    this.currentValueFieldTarget.value = currentValue;

    // Mostra o modal
    this.modalTarget.classList.remove("hidden");
  }

  close() {
    // Esconde o modal
    this.modalTarget.classList.add("hidden");
  }
}
