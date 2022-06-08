
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
              <div class="card-search-result" data-bs-toggle="modal" data-bs-target="#s${collection.id}" data-bs-dismiss="modal" data-collection="${collection.id}" data-action="click->watchlist#add">
                <div class="card-search-result-content">
                  <img src="${collection.image}" alt="Collection image" class="card-search-result-image" %>
                  <div class="card-search-result-content-header">
                    ${collection.name}
                  </div>
                </div>
                <a class="btn modal-search-collection-add" rel="nofollow" data-method="post" href="/collections/${collection.id}/watchlist_items">Add</a>
                  <button class="">Add</button>
                </div>
              </div>
            </div>
          </div>

          <div class="modal fade" id="s${collection.id}" aria-hidden="true" aria-labelledby="s${collection.id}" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">${collection.name}</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  Hide this modal and show the first with the button below.
                </div>
                <div class="modal-footer">
                  <button class="btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal" data-bs-dismiss="modal">Back to first</button>
                </div>
              </div>
            </div>
          </div>`

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
