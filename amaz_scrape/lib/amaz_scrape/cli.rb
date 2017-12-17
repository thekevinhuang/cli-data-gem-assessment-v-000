
class AmazScrape::CLI
  #first greet the user
  #ask user what item they would like to look at
  #show list of items
  #ask user if they would like additional detail on any in the list
  #allow them to quit/reprint list/re-enter a new item to search
  #

  def call

    input = "start"

    while input.strip.downcase != "exit"
      puts "Please type an item that you would like to search on Amazon!"
      puts "Type 'exit' to quit"

      input = gets.strip
      if input != "exit"
        puts "You've selected #{input}!"
        list_items
        explore_list
        #secondary loop with the following choices:
        #1. select one of the items
        #2. go back to item select
        #3. exit the program completely
      end

    end
    puts "Thanks for using!"
  end

  def list_items
    item = "placeholder" #change to real amazon item later/for loop
    print_item(item)
  end

  def print_item(amaz_item)
    puts "Example Pot - by Lodge - $49.99 - 4.6 Stars - Prime Available"

    #puts "#{name} - by #{manufacturer} - #{price} - #{rating} - #{prime_token}
  end

  def explore_list

  end
end
