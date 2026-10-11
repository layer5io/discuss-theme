import Component from "@glimmer/component";
import { service } from "@ember/service";
import CategoryBoxes from "./category-boxes";
import CategoryHeader from "./category-header";

export default class CustomCategoryBoxes extends Component {
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

  <template>
    <div class={{this.classNames}}>
      {{#if this.shouldRenderHeadings}}
        {{#if this.firstCategories}}
          <CategoryHeader @header={{settings.first_categories_header}} />
          <CategoryBoxes @categories={{this.firstCategories}} />
        {{/if}}

        {{#if this.secondCategories}}
          <CategoryHeader @header={{settings.second_categories_header}} />
          <CategoryBoxes @categories={{this.secondCategories}} />
        {{/if}}

        {{#if this.thirdCategories}}
          <CategoryHeader @header={{settings.third_categories_header}} />
          <CategoryBoxes @categories={{this.thirdCategories}} />
        {{/if}}

        {{#if this.fourthCategories}}
          <CategoryHeader @header={{settings.fourth_categories_header}} />
          <CategoryBoxes @categories={{this.fourthCategories}} />
        {{/if}}

        {{#if this.fifthCategories}}
          <CategoryHeader @header={{settings.fifth_categories_header}} />
          <CategoryBoxes @categories={{this.fifthCategories}} />
        {{/if}}
      {{else}}
        <CategoryBoxes @categories={{@outletArgs.categories}} />
      {{/if}}
    </div>
  </template>
}
