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
    points.each.sum
  end

  def ace_count
  end


  def bet(bank)
    @cash -= 10
    bank.bank_size +=10
  end

  def take_card
  end

  def add_cards(cards)
    @cards.push(cards)
  end

  def show_cards
    @user_cards = []
    @cards.each do |i|
      i.each_key { |key| @user_cards << key }
    end
    puts @user_cards.to_s
  end
end