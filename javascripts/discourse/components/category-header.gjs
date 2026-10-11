const CategoryHeader = <template>
  {{#if @header}}
    <h1 class="custom-category-header">
      {{@header}}
    </h1>
  {{/if}}
</template>;

export default CategoryHeader;
