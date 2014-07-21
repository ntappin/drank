require 'twitter'
require 'io/console'
require 'yaml'
load 'creds.rb'

@log = YAML.load_file('log.yml')
@tally = {}

def stdin_to_person(input)
  case input
  when 'w'
    "Ben"
  when 'a'
    "Nathan"
  when 's'
    "Lydia"
  when 'd'
    "Alex"
  when 'f'
    "Hugh"
  when 'g'
    "David"
  when 'q'
    "Wilson"
  when ' '
    "Mitch"
  when 's'
    "Massaad"
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
  @twitter.update("#{winner[0]} DRANK the most with #{winner[1]} points! They have won #{@log['Winners'][winner[0]]} times")
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
  if @log['Winners'][winner[0]].nil?
    @log['Winners'][winner[0]] = 1
  else
    @log['Winners'][winner[0]] = @log['Winners'][winner[0]] + 1
  end
  File.open('log.yml', 'w') {|f| f.write @log.to_yaml}
end

def speaker
  loop do
    unless @tally.empty?
      winner = determine_winner
      log_winner(winner)
      tweeter(winner)
      @tally.clear
      sleep 60
    end
  end
end

listenThread = Thread.start{listener}
speakThread = Thread.start{speaker}

listenThread.join
speakThread.join
