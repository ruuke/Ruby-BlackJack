require_relative 'desk'

class Rounds
  
  def initialize
    @desk = Desk.new
    
  end

  def give_cards(user, number_of_cards)
    sample = @desk.desk_new.keys.sample(number_of_cards)
    random_cards = @desk.desk_new.select { |key, value| sample.include?(key) }
    user.add_cards(random_cards)
    @desk.desk_new.delete_if { |key, value| sample.include?(key) }
  end

  def count_points
    points = []
    @cards.each { |i| points << i.values.sum }
    resualt = points.each.sum
    if resualt <= 11 && self.has_an_ace?
      resualt += 10
    else
      resualt
    end
  end

  def has_an_ace?
    show_cards.any?(/A/)
  end
end
