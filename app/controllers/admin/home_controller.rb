class Admin::HomeController < ApplicationController
  authorize_resource class: false
  
  def index
  end
end
