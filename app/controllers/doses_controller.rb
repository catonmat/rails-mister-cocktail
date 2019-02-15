class DosesController < ApplicationController

  def new
    @dose = Dose.new
    @ingredients = Ingredient.all
    @cocktail = Cocktail.find(params[:cocktail_id])
  end


  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail_id = params[:cocktail_id]
    if @dose.save
      redirect_to(cocktail_path(@cocktail))
    else
      render "cocktails/show"
    end
  end

  def destroy
    dose = Dose.find(params[:id])
    dose.destroy
  end

  private

  def dose_params
    params.require(:dose).permit(:ingredient_id, :description)
  end
end
