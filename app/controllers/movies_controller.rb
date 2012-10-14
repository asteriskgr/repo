class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

 
def index
  
   @all_ratings = Movie.ratings

   commit = params[:commit]
   if commit then
      @sort = params.fetch(:sort, {})
      @selected_ratings = params.fetch(:ratings, {})
      session[:selected_ratings] = @selected_ratings
   else
      @sort = params[:sort] || session[:sort]                        
      @selected_ratings = params[:ratings]
      if !@selected_ratings then
         sess_selected_ratings = session.fetch(:selected_ratings, nil)
          if sess_selected_ratings then
            redirect = true
            @selected_ratings = sess_selected_ratings
          else
            @selected_ratings = {}
          end
      else
        session[:selected_ratings] = @selected_ratings
      end
   end

   if session[:sort] != @sort then
      redirect = true
      session[:sort] = @sort
   end
   if redirect then
      redirect_to movies_path(:sort => @sort, :ratings => @selected_ratings)
   return
   end

   @movies = Movie

  if @sort then
     @movies = @movies.order(@sort)
  end

  if @selected_ratings.empty? then
      @movies = @movies.all
  else
      @movies = @movies.where("rating in (?)", @selected_ratings.keys)
  end
end

  
  def new
    
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
