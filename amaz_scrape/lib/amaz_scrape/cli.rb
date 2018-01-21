require_relative "../amaz_scrape.rb"

class AmazScrape::CLI
  #first greet the user
  #ask user what item they would like to look at
  #show list of items
  #ask user if they would like additional detail on any in the list
  #allow them to quit/reprint list/re-enter a new item to search
  #
  attr_reader :amz_item_list, :scraper

  @amz_item_list = []

  def initialize
    
  end

  def amz_item_list=(scraped_items)
    if scraped_items.all? { |item| item.is_a?(AmazScrape::Amazon_Item) }
      @amz_item_list = scraped_items
    end
  end

  def call
    input = "start"

    while input.strip.downcase != "exit"
      puts "Please type an item that you would like to search on Amazon!"
      puts "Type 'exit' to quit"
      print_separator

      input = gets.strip
      if input != "exit"
        puts "You've selected #{input}!"
        print_separator
        self.amz_item_list = scrape_items(input)#should just be the array
        print_items
        #secondary loop with the following choices:
        #1. select one of the items
        #2. go back to item select
        #3. exit the program completely
      end

    end
    puts "Thanks for using!"
  end


  def amz_item_list
    @amz_item_list
  end

  def scrape_items(input)

    @scraper = AmazScrape::Scraper.new(input)

    #create scraper class, and scrape method
    #have that scrape item return an array of items

    @scraper.scrape
    @scraper.scraped_items
  end

  def print_items #just physically lists items and accesses the items from an array
    if !self.amz_item_list.empty?
      self.amz_item_list.each_with_index do |item,i| #change to real amazon item later/for loop
        print_item(item,i)
      end
      input = explore_list
    else
      print_separator
      puts "Nothing to show!"
      print_separator
    end
  end

  def print_item(amaz_item, index)
    #puts "Example Pot - by Lodge - $49.99 - 4.6 Stars - Prime Available"

    puts "#{index+1}. | #{amaz_item.name} -- by #{amaz_item.maker} -- $#{amaz_item.price} -- #{amaz_item.rating} -- #{amaz_item.prime_token}"
  end

  def explore_list
    input = "explore"
    while input.strip.downcase != "exit" and input.strip.downcase != "back"
      puts "Please enter the number of the item you would like to explore or enter \"back\" to retype a new product or enter \"exit\" to quit"
      print_separator
      input = gets

      if input.strip.downcase == "back"
        print_separator
        puts "time to go back!"
      elsif input.strip.downcase == "exit"
        print_separator
        puts "exit time!!"
      else
        if valid_input?(input)
          self.scraper.detail_scrape(self.amz_item_list[input.to_i-1].link)
        end
        #tests the validity of the entry (count of things in the array storing list items/ is a number etc)
      end

    end
    input
  end

  def valid_input?(input)
    int_input = input.to_i
    value = true
    if int_input > 0 and int_input <= self.amz_item_list.length
      value = true
    else
      puts "This input is not valid. Please enter a new response"
      print_separator
      value = false
    end
    value
  end

  def print_separator
    puts "---------------\n"
  end
end
