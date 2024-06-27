# frozen_string_literal: true

RSpec.describe "Viewing category boxes", system: true do
  fab!(:theme) { upload_theme_component }
  fab!(:category_1) { Fabricate(:category, name: "New Category") }
  fab!(:category_2) { Fabricate(:category, name: "Fresh Category") }

  it "displays the category boxes" do
    visit "/categories"

    expect(page).to have_css(".custom-category-boxes")
    expect(page).to have_selector(".category-box", count: 3)

    expect(page).to have_selector(
      ".category-box[data-category-id='#{category_1.id}'] .category-abbreviation",
      exact_text: "Nc",
    )

    expect(page).to have_selector(
      ".category-box[data-category-id='#{category_2.id}'] .category-abbreviation",
      exact_text: "Fc",
    )
  end
end
