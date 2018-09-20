require_relative 'player'
require_relative 'dealer'
require_relative 'bank'
require_relative 'desk'

class Main
  #MainMenu
  def initialize
  end

  def start
    puts "That's your name?"
    name = gets.chomp
    @player = Player.new(name)
    @dealer = Dealer.new
    @bank = Bank.new
    @desk = Desk.new
    puts @desk.desk
  end
end

@newgame = Main.new
@newgame.start