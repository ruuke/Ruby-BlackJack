require_relative 'users'
require_relative 'bank'
require_relative 'desk'
require_relative 'rounds'

class Game
  #attr_accessor :bank
  attr_reader :desk, :status

  def initialize(player_name)
    @player = Users.new(player_name)
    @dealer = Users.new
  end

  def new_game
    @bank = Bank.new
    @player.cards = []
    @dealer.cards = []
    @rounds = Rounds.new
    @status = {}
    round1
  end

  def round1
    @rounds.give_cards(@dealer, 2)
    @rounds.give_cards(@player, 2)
    @player.bet(@bank)
    @dealer.bet(@bank)
    status[:bank] = @bank.bank_size
    status[:player_score] = @player.count_points
    status[:player_cards] = @player.show_cards
    status[:dealer_score] = "hidden"
    status[:dealer_cards] = "hidden"
    status[:status] = "player turn"
  end

  def dealer_step_round2
    if @dealer.count_points >= 17
      status[:status] = "Dealer check's."
    elsif @dealer.count_points < 17
      @rounds.give_cards(@dealer, 1)
      status[:status] = "Dealer took one card."
    end
  end

   def dealer_step_round3
    if @dealer.count_points >= 17
      status[:status] = "Dealer check's."
      open_cards
    elsif @dealer.count_points < 17
      @rounds.give_cards(@dealer, 1)
      status[:status] = "Dealer took one card."
      open_cards
    end
  end

  def take_one_card_round2
    @rounds.give_cards(@player, 1)
    dealer_step_round3
  end

  def take_one_card_round3
    @rounds.give_cards(@player, 1)
    open_cards
  end

  def open_cards
    if @dealer.count_points > 21 && @player.count_points <= 21
      player_win
    elsif @dealer.count_points <= 21 && @player.count_points > 21
      player_lose
    elsif @dealer.count_points > 21 && @player.count_points > 21
      draw(@player, @dealer)
    elsif @dealer.count_points > @player.count_points
      player_lose
    elsif @dealer.count_points < @player.count_points
      player_win
    elsif @dealer.count_points == @player.count_points
      draw(@player, @dealer)    
    end
    status[:player_score] = @player.count_points
    status[:player_cards] = @player.show_cards
    status[:dealer_score] = @dealer.count_points
    status[:dealer_cards] = @dealer.show_cards
    status[:player_cash] = @player.cash
    status[:dealer_cash] = @dealer.cash
  end

  private

  def player_lose
    status[:status] = "You lose."
    take_bank(@bank, @dealer)
  end

  def player_win
    status[:status] = "You win."
    take_bank(@bank, @player)
  end

  def draw(player, dealer)
    status[:status] = "Both wins"
    player.cash += 10
    dealer.cash += 10
  end

  def take_bank(bank, user)
    user.cash += bank.bank_size
  end
end
