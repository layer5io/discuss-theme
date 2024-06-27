import Component from "@glimmer/component";
import { htmlSafe } from "@ember/template";

export default class extends Component {
  get backgroundColor() {
    return htmlSafe(`background-color: #${this.args.category.color}`);
  }

  get getAbbreviation() {
    let abbr = this.args.category.name.replace(" and", "").split(" ");

    if (abbr.length > 1) {
      abbr = abbr[0].charAt(0).toUpperCase() + abbr[1].charAt(0).toLowerCase();
    } else {
      abbr = abbr[0].charAt(0).toUpperCase() + abbr[0].charAt(1).toLowerCase();
    }

    return abbr;
  }
}
