import { Controller } from "@hotwired/stimulus"

// Rails form helper wraps errored fields with div.field_with_errors
// which causes issues with the flex classes.
//
// To workaround this issue we do a switcharoo with the classes if they load.
//
export default class extends Controller {
  connect() {
    const div = this.element.querySelector('div.field_with_errors');
    if (div && this.element.children.length === 1) {
      div.classList.add(...this.element.classList);
      this.element.className = '';
    }
  }
}
