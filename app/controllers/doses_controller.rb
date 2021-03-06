class DosesController < ApplicationController
  before_action :find_cocktail, only: [:new, :create]
  def new
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    if params[:dose][:ingredient_id] != ""
      @ingredient = Ingredient.find(params[:dose][:ingredient_id])
      @dose.ingredient = @ingredient
      @dose.cocktail = @cocktail
      @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      @dose = Dose.new
      redirect_to new_cocktail_dose_path(@cocktail)
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    cocktail_id = @dose.cocktail_id
    @dose.delete

    redirect_to cocktail_path(cocktail_id)
  end

  private

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
