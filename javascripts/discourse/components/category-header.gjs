import { gt } from "discourse/truth-helpers";

const CategoryHeader = <template>
  {{#if (gt @header.length 0)}}
    <h1 class="custom-category-header">
      {{@header}}
    </h1>
  {{/if}}
</template>;

export default CategoryHeader;
