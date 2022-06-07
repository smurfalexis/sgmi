import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "input", "collection", "list"]

  connect() {
    console.log(this.formTarget)
    console.log(this.inputTarget)
    console.log(this.collectionTarget)
  }

  update() {
    const url = `${this.formTarget.action}?ajax_search=${this.inputTarget.value}`
    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data
        console.log(data)
      })
    }
}
