class User
  attr_accessor :cards, :cash
  attr_reader :name

  def initialize(*name)
    @name = name
    @cash = 100
    @cards = []
  end

  def count_points
    points = []
    @cards.each { |i| points << i.values.sum }
    result = points.sum
    if result <= 11 && self.has_an_ace?
      result += 10
    else
      result
    end
  end

  def has_an_ace?
    show_cards.each { |i| i.any?(/A/) }
  end

  def bet
     @cash -= 10
  end

  def add_cards(cards)
    @cards.push(cards)
  end

  def show_cards
    cards = []
    @cards.each { |i| cards << i.keys }
    cards
  end
end
