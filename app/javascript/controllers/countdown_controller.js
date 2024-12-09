import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["days", "hours", "minutes", "seconds"];
  static values = { targetDate: String };

  spinner_class = "absolute border-4 border-t-white border-gray-400 rounded-full w-10 h-10 animate-spin";
  number_class = "absolute text-4xl font-bold text-loveRed opacity-1 transition-opacity duration-200";
  first_time = true;

  connect() {
    this.targetTime = new Date(this.targetDateValue).getTime();

    if (!this.interval) {
      this.interval = setInterval(() => this.updateCountdown(), 1000);
    }
  }

  disconnect() {
    clearInterval(this.interval);
  }

  updateCountdown() {
    const now = new Date().getTime();
    const timeRemaining = Math.abs(this.targetTime - now);

    const totalSeconds = Math.floor(timeRemaining / 1000);
    const days = Math.floor(totalSeconds / (60 * 60 * 24));
    const hours = Math.floor((totalSeconds % (60 * 60 * 24)) / (60 * 60));
    const minutes = Math.floor((totalSeconds % (60 * 60)) / 60);
    const seconds = Math.floor(totalSeconds % 60);

    this.updateTarget(this.daysTarget, days);
    this.updateTarget(this.hoursTarget, hours);
    this.updateTarget(this.minutesTarget, minutes);
    this.updateTarget(this.secondsTarget, seconds);

    if (this.first_time) {
      this.first_time = false;
    }
  }

  updateTarget(target, value) {
    if (!target) return;

    if (this.first_time) {
      target.classList.add("opacity-0");
    }

    setTimeout(() => {
      target.textContent = value;

      target.classList.remove("opacity-0");
      target.className = this.number_class;
    }, this.first_time ? 200 : 0);
  }
}
