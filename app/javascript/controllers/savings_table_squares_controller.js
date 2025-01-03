import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["square", "total"];

  connect() {
    console.log("SavingsTableSquaresController connected!");
  }

  toggleChecked(event) {
    const square = event.currentTarget;
    const squareId = square.dataset.id;

    fetch(`/savings_table_squares/${squareId}/toggle_checked`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.success) {
          // Atualizar o estado do quadrado
          square.dataset.checked = data.checked;
          square.classList.toggle("bg-loveRed", data.checked);
          square.classList.toggle("bg-gray-700", !data.checked);

          // Atualizar o total no span
          if (this.hasTotalTarget) {
            this.totalTarget.textContent = data.new_total;
          }
        }
      })
      .catch((error) => console.error("Erro ao alternar o estado do quadrado:", error));
  }
}
