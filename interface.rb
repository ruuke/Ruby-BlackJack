require_relative 'game'

class Interface
  def initialize(player_name)
    @game = Game.new(player_name)
  end

  def start
    loop do
      puts "Press any key to start the game."
      puts "0. Exit."
      user_input = gets.chomp
      break if user_input == "0"
      if @game.player.cash > 0
        @game.new_game
      else
        puts "Get out needy!"
        exit
      end
      step1
    end
  end

  def show_info(hash_status)
    hash_status.each_pair { |key, value| puts "#{key} - #{value}" }
  end

  def step1
    user_input1 = nil
    until user_input1 =~ /1|2|3/
      show_info(@game.status)
      puts "Your options:"
      puts "1. Check."
      puts "2. Take one card."
      puts "3. Open cards."
      user_input1 = gets.chomp
      case user_input1
      when "1" then @game.dealer_step_round2
      when "2" then @game.take_one_card_round2
      when "3" then @game.open_cards
      end
    end
    step2 if user_input1 == "1"
    show_info(@game.status)
  end

  def step2
    user_input2 = nil
    until user_input2 =~ /1|2/
      show_info(@game.status)
      puts "Your options:"
      puts "1. Take one card."
      puts "2. Open cards."
      user_input2 = gets.chomp
      case user_input2
      when "1" then @game.take_one_card_round3
      when "2" then @game.open_cards
      end
    end
  end
end

player_name = nil
until player_name =~ /\S/
  puts "Welcome to BlackJack simulation. That's your name?"
  player_name = gets.chomp.capitalize
end

interface = Interface.new(player_name)
interface.start
