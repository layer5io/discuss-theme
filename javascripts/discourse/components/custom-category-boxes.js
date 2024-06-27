import Component from "@glimmer/component";
import { service } from "@ember/service";

export default class extends Component {
  @service router;
  @service site;

  get classNames() {
    const classNames = ["custom-category-boxes-container"];

    if (this.noneSelected) {
      classNames.push("none-selected");
    }

    return classNames.join(" ");
  }

  #allowedCategories(selectedCategories) {
    // filters categories to only include selected categories for each section
    let availableCategories = this.site.categories.filter((category) => {
      if (selectedCategories.indexOf(category.id) !== -1) {
        return true;
      } else {
        return false;
      }
    });

    return availableCategories;
  }

  get shouldRenderHeadings() {
    let isCategoryPage = this.router.currentRoute.name.includes("category");
    let hasCategoriesSet = false;

    if (
      settings.first_categories ||
      settings.second_categories ||
      settings.third_categories ||
      settings.fourth_categories ||
      settings.fifth_categories
    ) {
      hasCategoriesSet = true;
    }

    if (!isCategoryPage && hasCategoriesSet) {
      return true;
    } else {
      return false;
    }
  }

  get noneSelected() {
    return this.router.currentRoute.name.includes("None");
  }

  get firstCategories() {
    return this.#allowedCategories(
      settings.first_categories.split("|").map((id) => Number(id))
    );
  }

  get secondCategories() {
    return this.#allowedCategories(
      settings.second_categories.split("|").map((id) => Number(id))
    );
  }

  get thirdCategories() {
    return this.#allowedCategories(
      settings.third_categories.split("|").map((id) => Number(id))
    );
  }

  get fourthCategories() {
    return this.#allowedCategories(
      settings.fourth_categories.split("|").map((id) => Number(id))
    );
  }

  get fifthCategories() {
    return this.#allowedCategories(
      settings.fifth_categories.split("|").map((id) => Number(id))
    );
  }
}
