class FieldsController < ApplicationController
  def index
  end

  def new
    @field = Field.new
  end

  def create
    @field = Field.create(params[:field])

    if @field.save
      redirect_to field_path(@field)
    else
      render :status => 500 and return
    end
  end

  def edit
    @field = Field.find_by_id(params[:id])
  end

  def show
  end
end
