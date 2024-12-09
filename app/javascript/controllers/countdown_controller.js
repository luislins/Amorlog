import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["days", "hours", "minutes", "seconds"];
  static values = { targetDate: String }

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

    if (this.hasDaysTarget) this.daysTarget.textContent = days;
    if (this.hasHoursTarget) this.hoursTarget.textContent = hours;
    if (this.hasMinutesTarget) this.minutesTarget.textContent = minutes;
    if (this.hasSecondsTarget) this.secondsTarget.textContent = seconds;
  }
}
