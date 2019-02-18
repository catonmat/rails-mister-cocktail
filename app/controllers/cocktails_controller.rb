class CocktailsController < ApplicationController

  def index
    @cocktail = Cocktail.new
    @cocktails = Cocktail.all
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    @cocktail.update(cocktail_params)
    if @cocktail.save
      redirect_to(cocktail_path(@cocktail))
    else
      render "show"
    end
  end

  def new
    @cocktail = Cocktail.new
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @dose = Dose.new
    @ingredient = @cocktail.ingredients
  end

  def create
    @cocktails = Cocktail.all
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.id = params[:id]
    if @cocktail.save
      redirect_to(cocktail_path(@cocktail))
    else
      render "cocktails/index"
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, :instructions)
  end
end
