import { apiInitializer } from "discourse/lib/api";
import CustomCategoryBoxes from "../components/custom-category-boxes";

export default apiInitializer("1.14.0", (api) => {
  api.renderInOutlet("above-discovery-categories", CustomCategoryBoxes);
});
