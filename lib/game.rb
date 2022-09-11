require './scorecard'

@scorecard = Scorecard.new

def print_welcome
  print "Welcome to the bowling scorecard, please enter your rolls, when the game is over you will get your total score\n"
end

def get_roll
  print "Please input your roll score: \n"
  input = gets.chomp.to_i
  @scorecard.roll(input)
  print "Thank you for adding the roll! \n"
end

def get_score
  print "\nThank you for playing, your total score is #{@scorecard.total_score}\n"
end

print_welcome

while @scorecard.game_finished? == false do
  get_roll
end

get_score