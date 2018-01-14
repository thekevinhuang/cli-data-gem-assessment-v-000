require_relative "../amaz_scrape.rb"

class AmazScrape::Scraper
  AMZ_Websearch = "https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords="
  attr_accessor :item
  #attr_reader :name, :price, :manufacturer, :prime, :rating, :item_list

  def initialize(item)
    @item = item
    @amazon_noto_item_list = []
  end


  def item_valid?
    
    validation = false

    @item.strip!
    @item.gsub!(/ /, "%20")
    puts AMZ_Websearch+@item
    begin

      io_item = open(AMZ_Websearch+@item)
      connection_status = io_item.status[0]
      
      @page = Nokogiri::HTML(io_item)
      
      @amazon_noto_item_list = @page.css("body li.s-result-item")
      puts @amazon_noto_item_list.length

    rescue OpenURI::HTTPError => connection_error
      connection_status = connection_error.io.status[0]
      puts "Scraping instance failed with code #{connection_status}"
    end

    if !@amazon_noto_item_list.empty?
      validation = true
    else
      validation = false
    end

    validation
  end

  def read_item(amazon_noto_item)
    #page_item_hash = {}

    #need to be careful about the usage of .text because certain types will error out
    #implement an array empty check for this

    #create blank hash to store scraped information
    page_item_hash = {}

    #scrape name and store
    page_item_hash[:name] = amazon_noto_item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal").text
    puts page_item_hash[:name]

    #scrape price and store
    page_item_hash[:price] = text_if_not_empty(amazon_noto_item.css("span.a-offscreen"))
    puts page_item_hash[:price]
    
    
    #scrape maker and store WIP 
    page_item_hash[:maker] = text_if_not_empty(amazon_noto_item.css("div.a-row.a-spacing-none span.a-size-small.a-color-secondary")[1])
    puts page_item_hash[:maker]

    #scrape prime and store
    if amazon_noto_item.css("i.a-icon.a-icon-prime.a-icon-small.s-align-text-bottom span.a-icon-alt").text == "Prime"
      page_item_hash[:prime] = true
    else
      page_item_hash[:prime] = false
    end

    puts page_item_hash[:prime]

    #scrape rating and store
    page_item_hash[:rating] = text_if_not_empty(amazon_noto_item.css("i.a-icon-star span.a-icon-alt"))
    puts page_item_hash[:rating]

    #scrape link for clickthrough
    page_item_hash[:link] = amazon_noto_item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal").attribute('href').value


    amazon_item = AmazScrape::Amazon_Item.new(page_item_hash)

    amazon_item
  end

  def text_if_not_empty(amazon_item_element_array)
    if amazon_item_element_array
      if !amazon_item_element_array.empty?
        amazon_item_element_array.text
      end
    end
  end

  def scrape
    item_list = []

    if item_valid?

      @amazon_noto_item_list.each do |amazon_noto_item|
        item_list << read_item(amazon_noto_item)
      end

      item_list
    else
      puts "There were no results!"
      item_list
    end
  end
end
