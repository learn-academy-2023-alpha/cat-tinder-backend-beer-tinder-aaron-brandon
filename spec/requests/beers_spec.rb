require 'rails_helper'

RSpec.describe "Beers", type: :request do
  
  # Test to ensure that the get method works
  describe "GET /index" do
    it 'gets a list of beers' do
      Beer.create(
        name: 'test',
        brewery: 'testbrewery',
        abv: 4.0,
        ibu: 40,
        primary_flavor: 'coffee',
        secondary_flavor: 'chocolate',
        color: 'black',
        variety: 'stout'
      )
      get '/beers'
      beer = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(beer.length).to eq 1
    end
  end

  #Test to ensure the create method only works for valid entries
  describe "POST /create" do
    it 'creates a beer' do
      # Params we are going to send with the request
      beer_params = {
        beer: {
          name: 'test',
          brewery: 'testbrewery',
          abv: 4.0,
          ibu: 40,
          primary_flavor: 'coffee',
          secondary_flavor: 'chocolate',
          color: 'black',
          variety: 'stout'
        }
      }
      # send the request to the server
      post '/beers', params: beer_params

      # ensure we get a proper response back from the server
      expect(response).to have_http_status(200)
      
      #ensure that the object is in fact created
      beer = Beer.first
      expect(beer.name).to eq 'test'
    end
  end

  #Test to ensure data is validated upon update
  describe "PATCH /update" do
    it 'updates a beers data' do

      # create a set of params for the creation of a beer
      beer_params = {
        beer: {
          name: 'test',
          brewery: 'testbrewery',
          abv: 4.0,
          ibu: 40,
          primary_flavor: 'coffee',
          secondary_flavor: 'chocolate',
          color: 'black',
          variety: 'stout'
        }
      }

      #create a beer so that we can update it
      post '/beers', params: beer_params

      #set beer to the beer we created
      beer= Beer.first

      #create an updated set of params for our update 
      updated_beer_params = {
        beer: {
          name: 'getyoudrunkale',
          brewery: 'prisonyard',
          abv: 15.0,
          ibu: 90,
          primary_flavor: 'horrible',
          secondary_flavor: 'gross',
          color: 'whoknows',
          variety: 'toiletwine'
        }
      }

      #perform the update to the beer
      patch "/beers/#{beer.id}", params: updated_beer_params

      #set the updated_beer variable to the result of our patch request
      updated_beer = Beer.find(beer.id)

      #make sure we get back a good status code
      expect(response).to have_http_status(200)

      #make sure that the beer is actually updated
      expect(updated_beer.variety).to eq 'toiletwine'

    end
  end

  #Test to ensure data is validated upon delete
  describe "DELETE /destroy" do
    it 'removes a beer from the database' do
      beer_params = {
        beer: {
          name: 'test',
          brewery: 'testbrewery',
          abv: 4.0,
          ibu: 40,
          primary_flavor: 'coffee',
          secondary_flavor: 'chocolate',
          color: 'black',
          variety: 'stout'
        }
      }

      #create a beer so that we can delete it
      post '/beers', params: beer_params

      #set beers to our array of beers
      beers= Beer.all
      #set beer to equal the beer we created
      beer = Beer.first

      #delete the beer 
      delete "/beers/#{beer.id}"

      #make sure we get back a good status code
      expect(response).to have_http_status(200)
      
      #make sure that the last item in the beer array is NOT the beer we deleted
      expect(beers.last).to_not eq beer
    end
  end

  describe "meaningful status codes" do
    #checks for throwing a 422 upon bad create
    it "does not create a beer without a name" do
      beer_params = {
        beer: {
          brewery: 'testbrewery',
          abv: 4.0,
          ibu: 40,
          primary_flavor: 'coffee',
          secondary_flavor: 'chocolate',
          color: 'black',
          variety: 'stout'
        }
      }
      post '/beers', params: beer_params

      #expect an erorro if the beer_params does not have a name
      expect(response.status).to eq 422
      #convert the JSON response into a Ruby Hash
      json = JSON.parse(response.body)

      #expect that the errors will include a can't be blank error
      expect(json['name']).to include "can't be blank"
    end
    it "does not create a beer without a brewery" do
      beer_params = {
        beer: {
          name: 'testbeer',
          abv: 4.0,
          ibu: 40,
          primary_flavor: 'coffee',
          secondary_flavor: 'chocolate',
          color: 'black',
          variety: 'stout'
        }
      }
      post '/beers', params: beer_params

      #expect an erorro if the beer_params does not have a name
      expect(response.status).to eq 422
      #convert the JSON response into a Ruby Hash
      json = JSON.parse(response.body)

      #expect that the errors will include a can't be blank error
      expect(json['brewery']).to include "can't be blank"
    end


    #NOTE: I HAVE STOPPED ADDING THE UNVALIDATED ATTRIBUTES AS THEY ARE PRETTY MUCH A HUGE PAIN IN MY REAR END :-)
    #tests to ensure a 422 error is given when performing an invalid update - missing name
    it "does not update a beer without a brewery" do
      beer_params = {
        beer: {
          name: 'testname',
          brewery: 'testbrewery'
        }
      }
      post '/beers', params: beer_params

      #set beer to the beer we created
      beer= Beer.first

      #create an updated set of params for our update 
      updated_beer_params = {
        beer: {
          name: 'testname',
          brewery: nil
        }
      }

      #perform the update to the beer
      patch "/beers/#{beer.id}", params: updated_beer_params

      #set the updated_beer variable to the result of our patch request
      updated_beer = Beer.find(beer.id)

      #expect an erorr if the updated_beer_params does not have a name
      expect(response.status).to eq 422
      #convert the JSON response into a Ruby Hash
      json = JSON.parse(response.body)

      #expect that the errors will include a can't be blank error
      expect(json['brewery']).to include "can't be blank"
    end
    #tests to ensure a 422 error is given when performing an invalid update - missing brewery
    it "does not update a beer without a name" do
      beer_params = {
        beer: {
          name: 'testname',
          brewery: 'testbrewery'
        }
      }
      post '/beers', params: beer_params

      #set beer to the beer we created
      beer= Beer.first

      #create an updated set of params for our update 
      updated_beer_params = {
        beer: {
          name: nil,
          brewery: 'prisonyard'
        }
      }

      #perform the update to the beer
      patch "/beers/#{beer.id}", params: updated_beer_params

      #set the updated_beer variable to the result of our patch request
      updated_beer = Beer.find(beer.id)

      #expect an erorr if the updated_beer_params does not have a name
      expect(response.status).to eq 422
      #convert the JSON response into a Ruby Hash
      json = JSON.parse(response.body)

      #expect that the errors will include a can't be blank error
      expect(json['name']).to include "can't be blank"
    end

    #test to ensure that a 404 error is given when deleting an entry that wasn't found
    it 'throws a 404 error when deleting a nonexisting entry' do
      beer_params = {
        beer: {
          name: 'test',
          brewery: 'testbrewery',
          abv: 4.0,
          ibu: 40,
          primary_flavor: 'coffee',
          secondary_flavor: 'chocolate',
          color: 'black',
          variety: 'stout'
        }
      }

      #create a beer so that we can delete it
      post '/beers', params: beer_params

      #set beers to our array of beers
      beers= Beer.all
      #set beer to equal the beer we created
      beer = Beer.first

      #delete the beer 
      delete "/beers/invalidaddress"

      #make sure we get back a good status code
      expect(response).to have_http_status(404)
      
    end
  end
end
