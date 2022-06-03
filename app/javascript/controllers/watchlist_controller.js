import { Controller } from "stimulus"
import NodeWatchFileSystem from "webpack/lib/node/NodeWatchFileSystem";

export default class extends Controller {
  // static targets = [ "collection" ]

  connect() {
    console.log('Hello, Stimulus!');
  }

  add(event) {
    const id = event.currentTarget.dataset.collection
    const url = `/collections/${id}/watchlist_items`
    function getMetaValue(name) {
      const element = document.head.querySelector(`meta[name="${name}"]`)
      return element.getAttribute("content")
    }
    fetch(url, {
      method: "POST",
      headers: { "Accept": "text/plain", "X-CSRF-Token": getMetaValue("csrf-token")},
      body: {}
    })
    .then(response => response.text())
    .then((data) => {
      console.log(data)
    })
  }

}
