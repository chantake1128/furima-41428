class OrdersController < ApplicationController

  def index

  end
  
  def new
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)
    if @form.save
      redirect_to root_path
    end
  end

end
