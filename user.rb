class User
  attr_accessor :cards, :cash, :points, :step
  attr_reader :name

  def initialize(*name)
    @name = name
    @cash = 100
    @cards = []
    @points = 0
    @step = 0
  end

  def count_points
    @points = 0
    @cards.each do |i|      
      if i.value =~ /J|Q|K/
        @points += 10
      elsif i.value =~ /A/
        @points += 1
      else
        @points += i.value.to_i
      end          
    end
    if self.has_an_ace? && @points <= 11
      @points += 10
    else
      @points
    end
  end

  def has_an_ace?
    show_cards.any?(/A/)
  end

  def bet
     @cash -= 10
  end

  def add_cards(cards)
    @cards.push(cards)
  end

  def show_cards
    @cards.map { |card| card.show }
  end
end
