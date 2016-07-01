class FiguresController < ApplicationController
  
  get '/' do 
  end

  get '/figures/new' do 
    @titles = Title.all 
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    titles = Title.find_or_create_by(name: params[:title][:name])
    landmarks = Landmark.find_or_create_by(name: params[:landmark][:name])
    title_ids = params[:figure][:title_ids]
    landmark_ids = params[:figure][:landmark_ids]
    @figure = Figure.create(params[:figure])
    @figure.title_ids, @figure.landmark_ids = title_ids, landmark_ids
    @figure.titles << titles
    @figure.landmarks << landmarks 
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures' do
    @figures = Figure.all 
    erb :'figures/index'
  end

  get '/figures/:id' do 
    @figures = Figure.find(params[:id])
    @titles, @landmarks = @figures.titles, @figures.landmarks
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @titles = Title.all
    @landmarks = Landmark.all
    @figure = Figure.find(params[:id])
    
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    # binding.pry
    @figure.update(params[:figure])
      if params[:landmark][:name].any?
        @figure.landmarks << Landmark.create(params[:landmark])
      end
    redirect to "/figures/#{@figure.id}"

  end
end

