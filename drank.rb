require 'twitter'
require 'io/console'
load 'creds.rb'

@queue = []
@twitter

def stdin_to_person(input)
  case input
  when 'b'
    "Ben"
  when 'n'
    "Nathan"
  when 'l'
    "Lydia"
  when 'a'
    "Alex"
  when 'h'
    "Hugh"
  when 'd'
    "David"
  when 'w'
    "Wilson"
  when 'm'
    "Mitch"
  when 's'
    "Massad"
  else
    "Someone"
  end
end

def tweet_queue(drank)
  @queue.push(drank)
end

def tweeter(person)
  @twitter.update("#{person} just took a DRANK!")
end

loop do

  input = STDIN.getch
  if input == "\\"
    break
  end

  tweet_queue(input)
  tweeter(stdin_to_person(@queue.pop))

end
