require "sinatra"
require "sinatra/reloader" if development?

DEFEATS = { rock:     [:scissors, :lizard],
            paper:    [:rock, :spock], 
            scissors: [:paper, :lizard],
            lizard:   [:spock, :paper],
            spock:    [:rock, :scissors] }

get('/') do
  erb :throw, locals: {choices: DEFEATS.keys}
end

get('/throw/:choice') do
  # make other choice, see who won, etc.
  p_throw = params[:choice].to_sym
  c_throw = DEFEATS.keys.sample
  
  if p_throw == c_throw
    result = "tie"
  elsif DEFEATS[p_throw].include? c_throw
    result = "player wins"
  else
    result = "computer wins"
  end
  
  erb :outcome, locals: { p_throw: p_throw,
                          c_throw: c_throw,
                          result:  result }
end