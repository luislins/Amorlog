import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "form"];

  connect() {
  }

  open(event) {
    event.preventDefault();
    const goalId = event.currentTarget.dataset.goalId;
    const formAction = this.formTarget.getAttribute("data-base-url").replace("0", goalId);
    console.log(formAction)
    this.formTarget.setAttribute("action", formAction);
    this.modalTarget.classList.remove("hidden");
  }

  close(event) {
    event.preventDefault();
    this.modalTarget.classList.add("hidden")
  }
}
