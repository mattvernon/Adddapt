module ApplicationHelper
  def resource_name
    :designer
  end

  def resource
    @resource ||= Designer.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:designer]
  end
end
