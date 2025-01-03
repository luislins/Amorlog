// app/javascript/controllers/savings_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["grid", "totalInput", "maxInput", "currentTotal"];
  static values = { goalId: Number, saveUrl: String };

  connect() {
    this.total = 0;
    this.markedSquares = new Set(); // Armazena os valores marcados
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

    const squares = this.generateSquares(totalValue, maxValue);

    squares.forEach((value) => {
      const square = document.createElement("div");
      square.className =
        "w-12 h-12 flex items-center justify-center bg-gray-700 rounded-md text-white font-bold cursor-pointer hover:bg-loveRed transition-all";
      square.innerText = value;
      square.dataset.savingsValue = value;
      square.dataset.savingsStatus = "unmarked";
      square.addEventListener("click", this.toggle.bind(this));

      this.gridTarget.appendChild(square);
    });

    this.saveMarkedSquares(); // Salva os valores gerados inicialmente
  }

  generateSquares(totalValue, maxValue) {
    const squares = [];
    let remaining = totalValue;

    while (remaining > 0) {
      const value = Math.min(Math.ceil(Math.random() * maxValue), remaining);
      squares.push(value);
      remaining -= value;
    }

    return squares;
  }

  toggle(event) {
    const square = event.currentTarget;
    const value = parseInt(square.dataset.savingsValue, 10);
    const status = square.dataset.savingsStatus;

    if (status === "unmarked") {
      square.dataset.savingsStatus = "marked";
      square.classList.add("bg-loveRed");
      this.total += value;
      this.markedSquares.add(value);
    } else {
      square.dataset.savingsStatus = "unmarked";
      square.classList.remove("bg-loveRed");
      this.total -= value;
      this.markedSquares.delete(value);
    }

    this.updateTotal();
    this.saveMarkedSquares(); // Salva os valores atualizados
  }

  updateTotal() {
    this.currentTotalTarget.innerText = this.total;
  }

  async saveMarkedSquares() {
    try {
      const response = await fetch(this.saveUrlValue, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        },
        body: JSON.stringify({
          marked_values: Array.from(this.markedSquares),
        }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        console.error("Erro ao salvar os dados:", errorData);
      }
    } catch (error) {
      console.error("Erro ao salvar os dados:", error);
    }
  }
}
