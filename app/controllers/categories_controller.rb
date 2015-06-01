class CategoriesController < InheritedResources::Base
	before_action :require_admin
  private

    def category_params
      params.require(:category).permit(:name)
    end
end

