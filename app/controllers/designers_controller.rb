class DesignersController < ApplicationController
  before_action :set_designer, only: [:dashboard, :show, :edit, :update, :destroy]
  before_action :authenticate_designer!, only: [:dashboard, :edit, :destroy]
  before_filter :require_permission, only: [:dashboard, :edit]

  def dashboard
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @designer.update(designer_params)
        format.html { redirect_to @designer, notice: 'designer was successfully updated.' }
        format.json { render :show, status: :ok, location: @designer }
      else
        format.html { render :edit }
        format.json { render json: @designer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def set_designer
    @designer = Designer.find(params[:id])
  end

  def require_permission
    if current_designer != Designer.find(params[:id])
      redirect_to root_path
    end
  end

  def designer_params
    params.require(:designer).permit(:first_name, 
                                     :last_name, 
                                     :email, 
                                     :location, 
                                     :bio, 
                                     :website_url, 
                                     :facebook_url, 
                                     :dribbble_url, 
                                     :profile_pic, 
                                     :uid, 
                                     :provider, 
                                     :access_code, 
                                     :publishable_key)
  end

end





























