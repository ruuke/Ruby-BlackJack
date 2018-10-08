class Deck
  attr_reader :deck

  def initialize
    @deck = {}
    create_deck
  end

  def create_deck
    create_cards
    create_suited_cards
    @deck = @deck.merge(@clubs).merge(@dimonds).merge(@hearts).merge(@spades)
  end

  def give_cards
    sample = @deck.keys.sample
    random_card = @deck.select { |key, value| sample.include?(key) }
    @deck.delete_if { |key, value| sample.include?(key) }
    random_card
  end

  private

  def create_cards
    numbers = Hash[('2'..'10').collect { |card| [card.to_s, card.to_i] }]
    images = Hash[%w[J Q K].collect { |card| [card.to_s, 10] }]
    images['A'] = 1
    @cards = numbers.merge(images)
  end

  def create_suited_cards
    @clubs = @cards.transform_keys { |key| key + "+" }
    @dimonds = @cards.transform_keys { |key| key + "<>" }
    @hearts = @cards.transform_keys { |key| key + "<3" }
    @spades = @cards.transform_keys { |key| key + "^" }
  end
end
