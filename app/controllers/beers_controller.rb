class BeersController < ApplicationController
    def index
        beers = Beer.all
        render json: beers
    end

    def create
        beer = Beer.create(beer_params)
        if beer.valid?
            render json: beer 
        else
            render json: beer.errors, status: :unprocessable_entity
        end
    end

    def update
        beer = Beer.find(params[:id])
        beer.update(beer_params)
        if beer.valid?
            render json: beer
        else
            render json: beer.errors, status: :unprocessable_entity
        end
    end

    def destroy
        beer = Beer.find(params[:id])
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
