class LandmarksController < ApplicationController
  get '/' do 
  end

  get '/landmarks/new' do 
    erb :'landmarks/new'
  end

  post '/landmarks' do
    @landmarks = Landmark.create(params[:landmark])
    redirect to "/landmarks/#{@landmarks.id}"
  end

  get '/landmarks' do
    @landmarks = Landmark.all 
    erb :'landmarks/index'
  end

  get '/landmarks/:id' do
    @landmarks = Landmark.find(params[:id])
    erb :'landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.update(params[:landmark])
    redirect to "/landmarks/#{@landmark.id}"
  end


end
