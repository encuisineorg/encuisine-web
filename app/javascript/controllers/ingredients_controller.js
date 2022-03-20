import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "template", "links" ]

  connect() {}

  add(event) {
    event.preventDefault();

    let content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.linksTarget.insertAdjacentHTML("beforebegin", content)
  }

  remove(event) {
    event.preventDefault();

    let wrapper = event.target.closest(".fields")
    wrapper.remove()
  }
}
