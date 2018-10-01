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
end
