import Component from "@glimmer/component";
import { trustHTML } from "@ember/template";
import CategoryLogo from "discourse/components/category-logo";
import CategoryTitleBefore from "discourse/components/category-title-before";
import CategoryTitleLink from "discourse/components/category-title-link";
import PluginOutlet from "discourse/components/plugin-outlet";
import borderColor from "discourse/helpers/border-color";
import categoryLink from "discourse/helpers/category-link";
import icon from "discourse/helpers/d-icon";
import lazyHash from "discourse/helpers/lazy-hash";

export default class CategoryBox extends Component {
  get backgroundColor() {
    return trustHTML(`background-color: #${this.args.category.color}`);
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

  <template>
    <div
      data-category-id={{@category.id}}
      data-notification-level={{@category.notificationLevelString}}
      data-url={{@category.url}}
      class="category category-box category-box-{{@category.slug}}
        {{if @category.isMuted 'muted'}}
        {{if @noCategoryStyle 'no-category-boxes-style'}}"
    >
      <div class="category-box-inner">
        <div
          class="category-logo
            {{if @category.uploaded_logo.url '' 'no-logo-present'}}"
        >
          {{#if @category.uploaded_logo.url}}
            <CategoryLogo @category={{@category}} />
          {{else}}
            <span class="category-abbreviation">
              {{this.getAbbreviation}}
            </span>
          {{/if}}
        </div>

        <div class="category-details">
          <div class="category-box-heading">
            <a class="parent-box-link" href={{@category.url}}>
              <h3>
                <CategoryTitleBefore @category={{@category}} />
                {{#if @category.read_restricted}}
                  {{icon "lock"}}
                {{/if}}
                {{@category.name}}
              </h3>
            </a>
          </div>

          <div class="description">
            <p>{{trustHTML @category.description_excerpt}}</p>
          </div>

          {{#if @category.isGrandParent}}
            {{#each @category.subcategories as |subcategory|}}
              <div
                data-category-id={{subcategory.id}}
                data-notification-level={{subcategory.notificationLevelString}}
                style={{borderColor subcategory.color}}
                class="subcategory with-subcategories
                  {{if subcategory.uploaded_logo.url 'has-logo' 'no-logo'}}"
              >
                <div class="subcategory-box-inner">
                  <CategoryTitleLink @tagName="h4" @category={{subcategory}} />
                  {{#if subcategory.subcategories}}
                    <div class="subcategories">
                      {{#each subcategory.subcategories as |subsubcategory|}}
                        {{#unless subsubcategory.isMuted}}
                          <span class="subcategory">
                            <CategoryTitleBefore @category={{subsubcategory}} />
                            {{categoryLink subsubcategory hideParent="true"}}
                          </span>
                        {{/unless}}
                      {{/each}}
                    </div>
                  {{/if}}
                </div>
              </div>
            {{/each}}
          {{else if @category.subcategories}}
            <div class="subcategories">
              {{#each @category.subcategories as |sc|}}
                <div class="subcategory">
                  <a class="subcategory-image-placeholder" href={{sc.url}}>
                    <CategoryLogo @category={{sc}} />
                  </a>
                  {{categoryLink sc hideParent="true"}}
                </div>
              {{/each}}
            </div>
          {{/if}}
        </div>

        <PluginOutlet
          @name="category-box-below-each-category"
          @connectorTagName=""
          @outletArgs={{lazyHash category=@category}}
        />
      </div>
    </div>
  </template>
}
