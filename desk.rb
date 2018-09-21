class Desk
  attr_reader :desk

  def initialize
    @desk = { "2+" => 2, "2<3" => 2, "2^" => 2, "2<>" => 2,
              "3+" => 3, "3<3" => 3, "3^" => 3, "3<>" => 3,
              "4+" => 4, "4<3" => 4, "4^" => 4, "4<>" => 4,
              "5+" => 5, "5<3" => 5, "5^" => 5, "5<>" => 5,
              "6+" => 6, "6<3" => 6, "6^" => 6, "6<>" => 6,
              "7+" => 7, "7<3" => 7, "7^" => 7, "7<>" => 7,
              "8+" => 8, "8<3" => 8, "8^" => 8, "8<>" => 8,
              "9+" => 9, "9<3" => 9, "9^" => 9, "9<>" => 9,
              "10+" => 10, "10<3" => 10, "10^" => 10, "10<>" => 10,
              "J+" => 10, "J<3" => 10, "J^" => 10, "J<>" => 10,
              "Q+" => 10, "Q<3" => 10, "Q^" => 10, "Q<>" => 10,
              "K+" => 10, "K<3" => 10, "K^" => 10, "K<>" => 10,
              "A+" => 1, "A<3" => 1, "A^" => 1, "A<>" => 1 }
  end

  def give_cards(user, numder_of_cards)
    sample = @desk.keys.sample(numder_of_cards)
    random_cards = @desk.select { |key, value| sample.include?(key) }
    user.add_cards(random_cards)
    @desk.delete_if { |key, value| sample.include?(key) }
  end
end
