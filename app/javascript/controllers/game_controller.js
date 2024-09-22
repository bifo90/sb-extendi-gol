import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = {
        id: Number
    };
    static targets = ["playButton"]

    gameAnimation() {
        setInterval(async () => {
            const request = await fetch(`/next_generation?game_id=${this.idValue}`, {
                method: "POST",
            })
            const response = await request.text()
            Turbo.renderStreamMessage(response)
        }, 1000)
    }
    async play() {
        console.log('play')
        this.gameAnimation()
    }

}