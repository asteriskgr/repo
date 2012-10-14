module MoviesHelper
     def oddness(count)
        count.odd? ?  "odd" :  "even"
     end
      
  
    def is_checked?(rating, selected_ratings)
        selected_ratings.include? rating
    end
end
