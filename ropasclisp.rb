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
  player_throw   = params[:choice].to_sym
  computer_throw = DEFEATS.keys.sample
  
  if player_throw == computer_throw
    result = "a tie"
  elsif DEFEATS[player_throw].include? computer_throw
    result = "player wins"
  else
    result = "computer wins"
  end
  
  erb :outcome, locals: { player_throw:   player_throw,
                          computer_throw: computer_throw,
                          result:         result }
end