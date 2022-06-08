import { Controller } from "stimulus"
import EvalSourceMapDevToolModuleTemplatePlugin from "webpack/lib/EvalSourceMapDevToolModuleTemplatePlugin"

export default class extends Controller {
  static targets = ["form", "input", "collection", "list"]

  connect() {
    console.log(this.formTarget)
    console.log(this.inputTarget)
    console.log(this.collectionTarget)
    console.log(this.listTarget)
  }

  update() {
    const url = `${this.formTarget.action}?ajax_search=${this.inputTarget.value}`
    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.innerHTML = data
        console.log(data)
      })
  }

  submission(event) {
    console.log(event)
    event.stopPropagation()
    event.preventDefault()
  }
}
