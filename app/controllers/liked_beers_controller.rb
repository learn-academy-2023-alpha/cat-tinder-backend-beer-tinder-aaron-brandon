class LikedBeersController < ApplicationController
    def index
        beers = LikedBeer.all
        render json: beers
    end

    def create
        beer = LikedBeer.create(beer_params)
        if beer.valid?
            render json: beer 
        else
            render json: beer.errors, status: :unprocessable_entity
        end
    end

    def update
        beer = LikedBeer.find(params[:id])
        beer.update(beer_params)
        if beer.valid?
            render json: beer
        else
            render json: beer.errors, status: :unprocessable_entity
        end
    end

    def destroy
        beer = LikedBeer.find(params[:id])
        beer.destroy
        if beer.destroy
            render json: beer
        else
            render json: beer.errors, status: :unprocessable_entity
        end
    end


    private
    def beer_params
    params.require(:beer).permit(
        :name, 
        :brewery, 
        :abv, 
        :ibu, 
        :primary_flavor, 
        :secondary_flavor, 
        :color, 
        :variety)
    end

end
