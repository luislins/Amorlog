import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["numericField", "kindSelect"];

  connect() {
    this.toggleNumericField(); // Estado inicial
  }

  toggleNumericField() {
    console.log(this.kindSelectTarget.value); // Debug para verificar o valor
    if (this.kindSelectTarget.value === "numeric") {
      this.numericFieldTarget.classList.remove("hidden");
    } else {
      this.numericFieldTarget.classList.add("hidden");
      this.numericFieldTarget.value = ""
    }
  }
}
