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
        const list = [];
        data.forEach((collection) => {
          list.push(
          `<div class="modal-search-container">
            <div class="modal-search-result-wrapper">
              <div class="card-search-result" data-bs-dismiss="modal" data-collection="${collection.id}">
                <div class="card-search-result-content">
                  <img src="${collection.image}" alt="Collection image" class="card-search-result-image" %>
                  <div class="card-search-result-content-header">
                    ${collection.name}
                  </div>
                </div>
                <a class="btn modal-search-collection-add" rel="nofollow" data-method="post" href="/collections/${collection.id}/watchlist_items" data-remote=true>Add</a>

                </div>
              </div>
            </div>
          </div>
`

          )
        });
        this.listTarget.innerHTML = list
      })
  }

  submission(event) {
    console.log(event)
    event.stopPropagation()
    event.preventDefault()
  }
}
