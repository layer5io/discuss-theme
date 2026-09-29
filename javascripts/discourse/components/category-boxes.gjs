import CategoryBox from "./category-box";

const CategoryBoxes = <template>
  <span class="custom-category-boxes">
    {{#each @categories as |category|}}
      <CategoryBox @category={{category}} />
    {{/each}}
  </span>
</template>;

export default CategoryBoxes;
