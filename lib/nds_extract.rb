$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'directors_database'

def directors_totals(nds)
  # Remember, it's always OK to pretty print what you get *in* to make sure
  # that you know what you're starting with!
  #
  #
  # The Hash result be full of things like "Jean-Pierre Jeunet" => "222312123123"
  result = {
  }
  #
  # Use loops, variables and the accessing method, [], to loop through the NDS
  # and total up all the
  # ...
  # ...
  # ...
  #
  #
  # Be sure to return the result at the end!
  pp nds[0]
  totals = {}
  count = 0
  
  while nds[count] do
    movie_count = 0
    totals[nds[count][:name]] = 0
    
    while nds[count][:movies][movie_count] do
      totals[nds[count][:name]] += nds[count][:movies][movie_count][:worldwide_gross]
      movie_count += 1
    end
    
    count += 1
  end
  
  totals
end
