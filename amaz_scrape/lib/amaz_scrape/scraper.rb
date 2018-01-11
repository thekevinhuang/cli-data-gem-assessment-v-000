require_relative "../amaz_scrape.rb"

class AmazScrape::Scraper
  AMZ_Websearch = "https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords="
  attr_accessor :item
  #attr_reader :name, :price, :manufacturer, :prime, :rating, :item_list

  def initialize(item)
    @item = item
  end

=begin
  def scrape_items
    if item_valid?
      scrape
    else

    end
  end
=end


  def item_valid?
    validation = true #false
    puts AMZ_Websearch+@item
    #@item.strip!
    #@item.gsub!(/ /, "%20")
    #@page = Nokogiri::HTML(open(AMZ_Websearch+@item))
    #@item_list = @page.css("li.s-result-item")
    #if @item_list.length > 1
    #  validation = true
    #else
    #  validation = false
    #end
    validation
  end

  def read_item(amazon_noto_item)
    #page_item_hash = {}
    if amazon_noto_item == 1
      item_hash = {:name => "Example Pot", :maker => "Lodge", :price => 49.99, :rating => 4.6, :prime => true}
    else
      item_hash = {:name => "Pota Examples", :maker => "Cast Iron Guys", :price => 109.99, :rating => 4.2, :prime => true}
    end
    amazon_item = AmazScrape::Amazon_Item.new(item_hash)

    amazon_item
  end

  def scrape
    item_counter = [1,2]
    item_list = []

    item_counter.each do |item_num|
      item_list << read_item(item_num)
    end

    item_list
=begin
    @item_list.each do |list_item|
    page_item_hash = {}
    @name = list_item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal").text
    print name
    @price = list_item.css("span.a-offscreen").text
    print price
    @manufacturer = list_item.css("div.a-row.a-spacing-none span.a-size-small.a-color-secondary")[1].text
    print manufacturer
    if list_item.css("i.a-icon.a-icon-prime.a-icon-small.s-align-text-bottom span.a-icon-alt").text == "Prime"
      @prime = true
    else
      @prime = false
    end
    print prime
    @rating = list_item.css("i.a-icon-star span.a-icon-alt").text
    print rating
    print list_item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal")
    @link = list_item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal").attribute('href').value
=end

  end
end
