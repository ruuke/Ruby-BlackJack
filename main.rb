require_relative 'player'
require_relative 'dealer'
require_relative 'bank'
require_relative 'desk'

class Main
  #MainMenu
  def initialize
  end

  def start
    puts "That's your name?"
    name = gets.chomp
    @player = Player.new(name)
    @dealer = Dealer.new
    round1
  end

  def new_game
    @bank = Bank.new
    @desk = Desk.new
    @player.cards = []
    @dealer.cards = []
    @desk.give_cards(@player, 2)
    @desk.give_cards(@dealer, 2)
    puts "Your cards #{@player.show_cards}"
    puts "Dealer cards [*][*]"
    puts "Your points #{@player.count_points}"
    @player.bet(@bank)
    @dealer.bet(@bank)
    puts "Bank size : #{@bank.bank_size}"
  end

  def round1
    loop do
      puts "Do you want to start a new game? (y/n)"
      user_input = gets.chomp.downcase
      break if user_input == "n"

      case user_input
      when "y" then new_game
      else 
        puts "Choose an avaliable option."
      end
      round2
    end
  end

  def round2
    puts "Your options:"
    puts "1. Check."
    puts "2. Take one card."
    puts "3. Open cards."
    user_input = gets.chomp
    case user_input
    when "1" then dealer_step_round2
    when "2" then take_one_card_round2
    when "3" then open_cards
    else
      puts "Choose an avaliable option."
    end
  end

  def dealer_step_round2
    if @dealer.count_points >= 17
      puts "Dealer check's."
      round3
    elsif @dealer.count_points < 17
      @desk.give_cards(@dealer, 1)
      puts "Dealer took one card."
      round3
    end
  end

   def dealer_step_round3
    if @dealer.count_points >= 17
      puts "Dealer check's."
      open_cards
    elsif @dealer.count_points < 17
      @desk.give_cards(@dealer, 1)
      puts "Dealer took one card."
      open_cards
    end
  end

  def take_one_card_round2
    @desk.give_cards(@player, 1)
    puts "Your cards #{@player.show_cards}"
    puts "Your points #{@player.count_points}"
    dealer_step_round3
  end

  def take_one_card_round3
    @desk.give_cards(@player, 1)
    puts "Your cards #{@player.show_cards}"
    puts "Your points #{@player.count_points}"
    open_cards
  end

  def round3
    puts "Your options:"
    puts "1. Take one card."
    puts "2. Open cards."
    user_input = gets.chomp
    case user_input
    when "1" then take_one_card_round3
    when "2" then open_cards
    else
      puts "Choose an avaliable option."
    end
  end

  def open_cards
    if @dealer.count_points > @player.count_points
      player_lose
    elsif @dealer.count_points < @player.count_points
      player_win
    elsif @dealer.count_points == @player.count_points
      puts "Both wins."
    end
  end

  def player_lose
    puts "Dealer points #{@dealer.count_points}"
    puts "Your points #{@player.count_points}"
    puts "You lose."
    take_bank(@bank, @dealer)
    puts "Dealer cash #{@dealer.cash}"
  end

  def player_win
    puts "Dealer points #{@dealer.count_points}"
    puts "Your points #{@player.count_points}"
    puts "You win."
    take_bank(@bank, @player)
    puts "Your cash #{@player.cash}"
  end


  def take_bank(bank, user)
    user.cash += bank.bank_size
  end
end

@newgame = Main.new
@newgame.start
