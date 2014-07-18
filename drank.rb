require 'twitter'
require 'io/console'
load 'creds.rb'

@tally = {}

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
    "Some Rando"
  end
end

def tweet_tally(drank)
  person = stdin_to_person(drank)
  if @tally[person].nil?
    @tally[person] = 1
  else
    @tally[person] += 1
  end
end

def tweeter(winner)
  @twitter.update("#{winner[0]} DRANK #{winner[1]} times for the win!")
end

def listener
  loop do
    input = STDIN.getch.chomp
    tweet_tally(input)
  end
end

def determine_winner
  @tally.max_by{|k,v| v}
end

def log_winner(winner)
  open('log.txt', 'a'){|f|
    f.puts "#{winner[0]},#{winner[1]}"
  }
end

def speaker
  loop do
    unless @tally.empty?
      winner = determine_winner
      tweeter(winner)
      log_winner(winner)
      @tally.clear
      sleep 60
    end
  end
end

listenThread = Thread.start{listener}
speakThread = Thread.start{speaker}

listenThread.join
speakThread.join
