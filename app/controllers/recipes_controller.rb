class RecipesController < ApplicationController
  def show
    response = connection.get("/api/v1/recipes/#{params[:id]}")
    if response.status.eql?(200)
      @json = response.body
    end
  end

  def new; end

  def create
    response = connection.post("/api/v1/recipes") do |request|
      request.body = recipe_params.to_json
    end
    if response.status.eql?(200)
      redirect_to recipe_path(response.body["id"]), notice: "Merci d'avoir contribué !"
    else
      render :new
    end
  end

  private

  def connection
    Faraday.new(ENV["ENCUISINE_API_BASE_URL"]) do |faraday|
      faraday.request :json
      faraday.response :json
    end
  end

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
