class RecipesController < ApplicationController
  def show
    response = Encuisine::Recipe.get(params[:id])
    if response.status.eql?(200)
      @json = response.body
    else
      render status: 404
    end
  end

  def new; end

  def create
    response = Encuisine::Recipe.create(recipe_params.to_json)
    if response.status.eql?(200)
      redirect_to recipe_path(response.body["id"]), notice: "Merci d'avoir contribué !"
    else
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :author,
      :content,
      :license,
      :source_url,
      :title,
      :total_minutes,
      ingredients_attributes: [
        :name,
        :quantity,
        :unit
      ]
    )
  end
end
