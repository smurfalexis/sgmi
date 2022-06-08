
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

  update(event) {
    console.log(event)
    const url = `${this.formTarget.action}.json?ajax_search=${this.inputTarget.value}`
    fetch(url, { headers: { "Accept":"Application/json" } })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })
  }

  submission(event) {
    console.log(event)
    event.stopPropagation()
    event.preventDefault()
  }
}
