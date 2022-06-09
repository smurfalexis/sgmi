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
          `<div class="drop-container-modal">
            <img src="${collection.image}" alt="Collection image" class="drop-image">
            <div class="card-xs-small-content-modal-search">
              <div class="card-xs-small-content-headers">
                ${collection.name}
              </div>

              <div class="modal-social-container-search">
              <a href="${collection.discord}" src="Discord" target="_blank" class="fa-brands fa-discord modal-social"></a>
              <a href="${collection.twitter}" src="Twitter" target="_blank" class="fa-brands fa-twitter modal-social"></a>
            </div>

            </div>
            <div class="modal-social-container">
              <a class="btn modal-search-collection-add" rel="nofollow" data-method="post" href="/collections/${collection.id}/watchlist_items" data-remote=true>Add</a>
            </div>
          </div>`
          )
        });
        this.listTarget.innerHTML = list.join("")
      })
  }

  submission(event) {
    console.log(event)
    event.stopPropagation()
    event.preventDefault()
  }
}
