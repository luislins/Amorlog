import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "form", "currentValueField"];

  open(event) {
    const goalId = event.currentTarget.dataset.goalId;

    this.formTarget.action = event.currentTarget.dataset.baseUrl.replace(":id", goalId);

    const currentValue = event.currentTarget.dataset.currentValue;
    this.currentValueFieldTarget.value = currentValue;

    this.modalTarget.classList.remove("hidden");
  }

  close() {
    this.modalTarget.classList.add("hidden");
  }
}
