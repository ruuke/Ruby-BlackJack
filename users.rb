class Users
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
    result = points.each.sum
    if result <= 11 && self.has_an_ace?
      result += 10
    else
      result
    end
  end

  def has_an_ace?
    show_cards.any?(/A/)
  end

  def bet(bank)
     @cash -= 10
     bank.bank_size +=10
  end

  def add_cards(cards)
    @cards.push(cards)
  end

  def show_cards
    @user_cards = []
    @cards.each do |i|
      i.each_key { |key| @user_cards << key }
    end
    @user_cards
  end
end
