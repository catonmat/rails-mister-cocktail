class CocktailsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      sql_query = <<-SQL
        name ILIKE :query
        OR instructions ILIKE :query
        OR ingredients.name ILIKE :query
      SQL
      @cocktail = Cocktail.new
      @cocktails = Cocktail.joins(:ingredients).where(sql_query, query: "%#{params[:query]}%")
      @cocktails = policy_scope(@cocktails)
    else
      @cocktail = Cocktail.new
      @cocktails = Cocktail.all
      @cocktails = policy_scope(@cocktails)
    end
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    authorize(@cocktail)
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
    authorize(@cocktail)
    @dose = Dose.new
    @ingredient = @cocktail.ingredients
  end

  def create
    @cocktails = Cocktail.all
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.user = current_user
    authorize(@cocktail)
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
