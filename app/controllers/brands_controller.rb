class BrandsController < ApplicationController
  before_action :authenticate_designer!, only: [:new, :edit, :destroy]
  before_action :set_brand, only: [:show, :edit, :update, :destroy]
  before_filter :require_permission, only: [:edit, :update, :destroy]
  after_action :set_first_brand_boolean_to_false, only: [:create]

  def index
    @brands = Brand.all
  end

  def show
    @preview_images = @brand.preview_images
  end

  def new
    @brand = current_designer.brands.new
  end

  def edit
    @preview_images = @brand.preview_images
  end

  def create
    @brand = current_designer.brands.new(brand_params)

    respond_to do |format|
      if @brand.save
        session[:brand_id] = @brand.id
        format.html { redirect_to create_brand_path(:brand_media), notice: 'Brand was successfully created.' }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to @brand, notice: 'Brand was successfully updated.' }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to brands_url, notice: 'Brand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def set_brand
      @brand = Brand.find_by(id: params[:id])
    end

    def require_permission
      @brand = current_designer.brands.find_by(id: params[:id])
      redirect_to root_path if @brand.nil?
    end

    # sets boolean to prevent multiple 
    # transaction emails after first brand upload
    def set_first_brand_boolean_to_false
      current_designer.first_brand = false
      current_designer.save
    end

    def brand_params
      params.require(:brand).permit(:name, 
                                    :description, 
                                    :price, 
                                    :thumbnail, 
                                    preview_images_attributes: [:image, :_destroy])
    end
end
