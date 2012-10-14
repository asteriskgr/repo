class ApplicationController < ActionController::Base
    def oddness(count)
        count.odd? ?  "odd" :  "even"
    end
  
    def hilite?(name, sort)
        name == sort ? "hilite" : nil 
    end
  
    def is_checked?(rating, selected_ratings)
        selected_ratings.include? rating
    end
end
