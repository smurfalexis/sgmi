import { Controller } from "stimulus"


export default class extends Controller {
  // static targets = [ "collection" ]

  connect() {
    console.log('Hello, Stimulus!');
  }

}
