class CocktailsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index

    @cocktail = Cocktail.new
    @cocktails = Cocktail.all
    @cocktails = policy_scope(Cocktail)
  end

  def update
    authorize(@cocktail)
    @cocktail = Cocktail.find(params[:id])
    @cocktail.update(cocktail_params)
    if @cocktail.save
      redirect_to(cocktail_path(@cocktail))
    else
      render "show"
    end
  end

  def edit
    authorize(@cocktail)
  end

  def new
    authorize(@cocktail)
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
    @cocktail = @current_user
    # @cocktail.id = params[:id]
    if @cocktail.save
      redirect_to(cocktail_path(@cocktail), notice: "Cocktail was successfully created.")
    else
      render "cocktails/index"
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, :instructions)
  end
end
