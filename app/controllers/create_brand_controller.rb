class CreateBrandController < ApplicationController
  include Wicked::Wizard

  steps :brand_media

  def show
    @designer = current_designer
    @brand = current_brand
    3.times { @brand.preview_images.build }
    render_wizard
  end

  def update
    @designer = current_designer
    @brand = current_brand
    @brand.update(brand_params)
    render_wizard @designer
  end

  private

  def brand_params
    params.require(:brand).permit(:name, 
                                  :description, 
                                  :price, 
                                  :thumbnail, 
                                  preview_images_attributes: [:image, :_destroy])
  end
end
