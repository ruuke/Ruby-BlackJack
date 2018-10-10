require_relative 'card'

class Deck
  SUITS = %w(♠ ♥ ♣ ♦)
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

  def initialize
    @deck = create_deck.shuffle
  end

  def create_deck
    SUITS.map{|suit| VALUES.map{|value| Card.new(suit, value)}}.flatten
  end

  def give_cards
    @deck.pop
  end
end
