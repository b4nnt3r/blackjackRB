puts "TODO Implement the game of blackjack."

class Player
  attr_accessor :score, :funds, :bet, :hand

  def initialize
    @hand = [];
    @score = 0;
    @bet = 0;
    @funds = 100;
  end

  def reset
    @hand = [];
    @score = 0;
    @bet = 0;
  end

  def hand(cards)
    @hand += cards
    calculate_score
  end

  def place_bet
    amount = 0
    while true
      begin
        amount = Integer(gets)
        if amount <= @funds && amount > 0
          @bet += amount
          @funds -= amount
          break
        elsif amount > @funds
          puts "Sadly, you don't have enough funds to place this bet. Please enter a lower bet."
        else
          puts "You cannot place a zero or negative bet."
        end
      rescue
        puts "Please enter a valid whole amount."
      end
    end
  end

  def update_funds(amount)
    @funds += amount
  end

  def calculate_score
    @score = 0
    ace_in_hand = false

    @hand.each do |h|
     face_value = h.get_value[1]
     if face_value.is_a? Integer
       @score += face_value
     elsif face_value != :Ace
       @score += FACEVALUE
     else
       @score += 1
       ace_in_hand = true
     end
    end

    if ace_in_hand
      if @score + FACEVALUE <= BLACKJACK then @score += FACEVALUE end
    end
  end

  def print_hand
    hand_as_string = ""
    @hand.each do |card|
      card_value = card.get_value
      hand_as_string += "#{card_value[0]}, #{card_value[1]} | "
    end
    return hand_as_string
  end
end

def determine_winner(player, dealer)

  amount = 0

  if dealer.score > BLACKJACK && player.score > BLACKJACK
    puts "\n**No one wins!**\n"
  elsif player.score < dealer.score && dealer.score <= BLACKJACK ||
    player.score > BLACKJACK
    puts "\n***Dealer wins***\n"
  elsif dealer.score < player.score && player.score <= BLACKJACK ||
    dealer.score > BLACKJACK
    puts "\n****Player wins!****\n"
    if player.score == BLACKJACK && player.hand.size == 2
      amount = player.bet + player.bet * 1.5
    else
      amount = player.bet * 2
    end
  else
    puts "\nIt's a draw!\n"
    amount = player.bet
  end

  player.update_funds(amount)

end
