require_relative 'logic'

class Interface
  def initialize(game)
    @game = game
  end

  def start
    loop do
      puts "Do you want ot start a new game? (y/n)"
      user_input = gets.chomp.downcase
      break if user_input == "n"
      case user_input
      when "y" then @game.new_game
      else
        puts "Choose an avaliable option."
        start
      end
      step1
      
    end
  end

  def step1
    
      puts "Your options:"
      puts "1. Check."
      puts "2. Take one card."
      puts "3. Open cards."
      user_input = gets.chomp
      case user_input
      when "1" then @game.dealer_step_round2
      when "2" then @game.take_one_card_round2
      when "3" then @game.open_cards
      else
        puts "Choose an avaliable option."
        step1
      end
      step2 if user_input == "1"
    
  end

  def step2
    puts "Your options:"
    puts "1. Take one card."
    puts "2. Open cards."
    user_input = gets.chomp
    case user_input
    when "1" then @game.take_one_card_round3
    when "2" then @game.open_cards
    else
      puts "Choose an avaliable option."
      step2
    end
  end

   
end


interface = Interface.new(Logic.new)
interface.start
