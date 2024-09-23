import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ['menu', 'button', 'iconMenuOpened', 'iconMenuClosed']

    connect() {

    }
    toggle() {
        this.menuTarget.classList.toggle('active')
        this.buttonTarget.classList.toggle('active')
        if (this.menuTarget.classList.contains('active')) {
            this.iconMenuOpenedTarget.classList.remove('hidden')
            this.iconMenuClosedTarget.classList.add('hidden')
        } else {
            this.iconMenuOpenedTarget.classList.add('hidden')
            this.iconMenuClosedTarget.classList.remove('hidden')
        }
    }
}