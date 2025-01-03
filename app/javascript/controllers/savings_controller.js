// app/javascript/controllers/savings_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["grid", "totalInput", "maxInput", "currentTotal"];
  static values = { saveUrl: String };

  connect() {
    this.total = 0;
    this.squares = []; // Armazena os quadrados e seus estados
  }

  generate() {
    const totalValue = parseInt(this.totalInputTarget.value, 10);
    const maxValue = parseInt(this.maxInputTarget.value, 10);

    if (!totalValue || !maxValue || totalValue < 1 || maxValue < 1) {
      alert("Por favor, insira valores válidos para o total e o valor máximo.");
      return;
    }

    this.gridTarget.innerHTML = ""; // Limpa o grid anterior
    this.total = 0;
    this.squares = [];

    let remaining = totalValue;

    while (remaining > 0) {
      const value = Math.min(Math.ceil(Math.random() * maxValue), remaining);
      this.squares.push({ value, marked: false });
      remaining -= value;
    }

    this.renderSquares();
    this.saveSquares(); // Salva os quadrados gerados
  }

  renderSquares() {
    this.gridTarget.innerHTML = ""; // Limpa o grid
    this.squares.forEach((square, index) => {
      const div = document.createElement("div");
      div.className =
        "w-12 h-12 flex items-center justify-center bg-gray-700 rounded-md text-white font-bold cursor-pointer hover:bg-loveRed transition-all";
      div.innerText = square.value;
      div.dataset.index = index;
      div.dataset.marked = square.marked;

      if (square.marked) {
        div.classList.add("bg-loveRed");
      }

      div.addEventListener("click", this.toggle.bind(this));
      this.gridTarget.appendChild(div);
    });
  }

  toggle(event) {
    const index = event.currentTarget.dataset.index;
    const square = this.squares[index];
    square.marked = !square.marked;

    this.total = this.squares
      .filter((sq) => sq.marked)
      .reduce((sum, sq) => sum + sq.value, 0);

    this.renderSquares();
    this.updateTotal();
    this.saveSquares(); // Atualiza os quadrados no servidor
  }

  updateTotal() {
    this.currentTotalTarget.innerText = this.total;
  }

  async saveSquares() {
    try {
      const response = await fetch(this.saveUrlValue, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        },
        body: JSON.stringify({
          squares: this.squares,
        }),
      });

      if (!response.ok) {
        console.error("Erro ao salvar os dados:", await response.json());
      }
    } catch (error) {
      console.error("Erro ao salvar os dados:", error);
    }
  }
}
