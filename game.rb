require_relative 'user'
require_relative 'deck'

class Game
  attr_reader :desk, :status, :player

  def initialize(player_name)
    @player = User.new(player_name)
    @dealer = User.new
  end

  def new_game
    @bank = 20
    @player.cards = []
    @dealer.cards = []
    @deck = Deck.new
    @status = {}
    round1
  end

  def round1
    2.times { @player.cards << @deck.give_cards }
    2.times { @dealer.cards << @deck.give_cards }
    @player.bet
    @dealer.bet
    status[:bank] = @bank
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
      @dealer.cards << @deck.give_cards
      status[:status] = "Dealer took one card."
    end
  end

  def dealer_step_round3
    dealer_step_round2
    open_cards
  end

  def take_one_card_round2
    @player.cards << @deck.give_cards
    dealer_step_round3
  end

  def take_one_card_round3
    @player.cards << @deck.give_cards
    open_cards
  end

  def open_cards
    if @dealer.count_points > 21 && @player.count_points <= 21
      player_win
    elsif @dealer.count_points <= 21 && @player.count_points > 21
      player_lose
    elsif @dealer.count_points > 21 && @player.count_points > 21
      draw
    elsif @dealer.count_points > @player.count_points
      player_lose
    elsif @dealer.count_points < @player.count_points
      player_win
    elsif @dealer.count_points == @player.count_points
      draw    
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
    take_bank(@dealer)
  end

  def player_win
    status[:status] = "You win."
    take_bank(@player)
  end

  def draw
    status[:status] = "Both wins"
    @player.cash += 10
    @dealer.cash += 10
  end

  def take_bank(user)
    user.cash += 20
  end
end
