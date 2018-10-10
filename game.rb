require_relative 'user'
require_relative 'deck'

class Game
  attr_reader :desk, :status, :player

  def initialize(player_name)
    @bank = 0
    @player = User.new(player_name)
    @dealer = User.new
  end

  def new_game
    reset
    @deck = Deck.new
    @status = {}
    round1
  end

  def round1
    2.times { @player.cards << @deck.give_cards }
    2.times { @dealer.cards << @deck.give_cards }
    @player.bet
    @dealer.bet
    game_info
  end

  def dealer_step_round2
    if @dealer.points >= 17
      status[:status] = "Dealer check's."
    elsif @dealer.points < 17
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
    @player.points
    dealer_step_round3
  end

  def take_one_card_round3
    @player.cards << @deck.give_cards
    open_cards
  end

  def open_cards
    @dealer.step = 1
    game_info
    if @dealer.points > 21 && @player.points <= 21
      player_win
    elsif @dealer.points <= 21 && @player.points > 21
      player_lose
    elsif @dealer.points > 21 && @player.points > 21
      draw
    elsif @dealer.points > @player.points
      player_lose
    elsif @dealer.points < @player.points
      player_win
    elsif @dealer.points == @player.points
      draw    
    end
    game_info
  end

  private

  attr_accessor :bank

  def reset
    @bank = 20
    @player.cards = []
    @dealer.cards = []
    @player.points = 0
    @dealer.points = 0
    @dealer.step = 0
  end

   def game_info
    status[:bank] = bank
    status[:player_score] = player_score
    status[:player_cards] = player_cards
    status[:dealer_score] = dealer_score
    status[:dealer_cards] = dealer_cards
    status[:player_cash] = @player.cash
    status[:dealer_cash ] = @dealer.cash
  end

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
    @bank = 0
  end

   def player_cards
    @player.show_cards
  end

  def player_score
    @player.count_points
  end

  def dealer_cards
    @dealer.step == 1 ? @dealer.show_cards : "Hidden"
  end

  def dealer_score
    @dealer.count_points
    @dealer.step == 1 ? @dealer.points : "Hidden"
  end
end
