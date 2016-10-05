class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by_id(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat.id)
    else
      render(
      @cat.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def edit
    @cat = Cat.find_by_id(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find_by_id(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat.id)
    else
      render(
      @cat.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

private
def cat_params
  params.require(:cat).permit(:name, :sex, :color, :birth_date, :description)
end

end
