require_relative 'users'
require_relative 'bank'
require_relative 'desk'
require_relative 'rounds'

class Logic
  attr_reader :desk

  def initialize
    @player = Users.new
    @dealer = Users.new
  end

  def new_game
    @bank = Bank.new
    @player.cards = []
    @dealer.cards = []
    @rounds = Rounds.new
    round1(@dealer, @player)
  end

  def round1(dealer, player)
    @rounds.give_cards(@dealer, 2)
    @rounds.give_cards(@player, 2)
    @player.bet(@bank)
    @dealer.bet(@bank)
    puts "Your cards #{player.show_cards.inspect}"
    puts "Your points #{player.count_points}" 
  end

  def dealer_step_round2
    if @dealer.count_points >= 17
      puts "Dealer check's."
    elsif @dealer.count_points < 17
      @rounds.give_cards(@dealer, 1)
      puts "Dealer took one card."
    end
  end

   def dealer_step_round3
    if @dealer.count_points >= 17
      puts "Dealer check's."
      open_cards
    elsif @dealer.count_points < 17
      @rounds.give_cards(@dealer, 1)
      puts "Dealer took one card."
      open_cards
    end
  end

  def take_one_card_round2
    @rounds.give_cards(@player, 1)
    puts "Your cards #{@player.show_cards}"
    puts "Your points #{@player.count_points}"
    dealer_step_round3
  end

  def take_one_card_round3
    @rounds.give_cards(@player, 1)
    puts "Your cards #{@player.show_cards}"
    puts "Your points #{@player.count_points}"
    open_cards
  end

  def open_cards
    puts "Dealer cards #{@dealer.show_cards}"
    puts "Dealer points #{@dealer.count_points}"
    puts "Your points #{@player.count_points}"
    if @dealer.count_points > 21 && @player.count_points <= 21
      player_win
    elsif @dealer.count_points <= 21 && @player.count_points > 21
      player_lose
    elsif @dealer.count_points > @player.count_points
      player_lose
    elsif @dealer.count_points < @player.count_points
      player_win
    elsif @dealer.count_points == @player.count_points && @player.count_points <= 21
      puts "Both wins."
      both_wins(@player, @dealer)
    elsif @dealer.count_points > 21 && @player.count_points > 21
      puts "Both lose."
      both_wins(@player, @dealer)
    end
  end

  def player_lose
    puts "You lose."
    take_bank(@bank, @dealer)
    puts "Dealer cash #{@dealer.cash}"
  end

  def player_win
    puts "You win."
    take_bank(@bank, @player)
    puts "Your cash #{@player.cash}"
  end

  def both_wins(player, dealer)
    player.cash += 10
    dealer.cash += 10
  end

  def take_bank(bank, user)
    user.cash += bank.bank_size
  end
end
