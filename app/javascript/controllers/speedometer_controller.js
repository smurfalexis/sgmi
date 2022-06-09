import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "profit", "speed", "score" ]

  connect() {
    console.log('Hello, Speedometer Stimulus!');
    console.log('yooooo', this.profitTarget.getAttribute("name"))
    console.log(this.speedTarget)
    const lowColor = [48, 232, 191]
    const highColor = [198, 81, 224]
    const profit  = Number(this.profitTarget.getAttribute("name"))

    let ratio = Math.abs(profit) / 10

    if (ratio >= 1 ) {
      ratio = 1
    }

    let degResult = (90 * ratio) + 45

    if( profit < 0) {
       degResult = (90 - degResult) - 90
    }
    const ratioColor = this.pickHex(lowColor, highColor, ratio)
    console.log(degResult, profit, ratioColor, ratio )
    this.speedTarget.style.borderColor = `transparent white rgb(${ratioColor[0]},${ratioColor[1]},${ratioColor[2]}) rgb(${ratioColor[0]},${ratioColor[1]},${ratioColor[2]})`;
    this.speedTarget.style.transform = "rotate(" + degResult + "deg)";
  }


  pickHex(color1, color2, weight) {
    var w1 = weight;
    var w2 = 1 - w1;
    var rgb = [Math.round(color1[0] * w1 + color2[0] * w2),
        Math.round(color1[1] * w1 + color2[1] * w2),
        Math.round(color1[2] * w1 + color2[2] * w2)];
    return rgb;
}

}
