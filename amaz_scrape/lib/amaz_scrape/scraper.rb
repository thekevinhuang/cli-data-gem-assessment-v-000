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
    validation = false

    @item.strip!
    @item.gsub!(/ /, "%20")
    puts AMZ_Websearch+@item
    @page = Nokogiri::HTML(open(AMZ_Websearch+@item))
    @amazon_noto_item_list = @page.css("ul#s-results-list-atf li[id^='result_']")
    puts @amazon_noto_item_list.length
    if @amazon_noto_item_list.length > 0
      validation = true
    else
      validation = false
    end
    validation
  end

  def read_item(amazon_noto_item)

=begin
    if amazon_noto_item == 1
      item_hash = {:name => "Example Pot", :maker => "Lodge", :price => 49.99, :rating => 4.6, :prime => true}
    else
      item_hash = {:name => "Pota Examples", :maker => "Cast Iron Guys", :price => 109.99, :rating => 4.2, :prime => true}
    end
=end


    page_item_hash = {}
    page_item_hash[:name] = amazon_noto_item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal").text
    puts page_item_hash[:name]
    page_item_hash[:price] = amazon_noto_item.css("span.a-offscreen").text
    puts page_item_hash[:price]
    binding.pry
    page_item_hash[:maker] = amazon_noto_item.css("div.a-row.a-spacing-none div.a-size-small.a-color-secondary")[1].text
    puts page_item_hash[:maker]
    if amazon_noto_item.css("i.a-icon.a-icon-prime.a-icon-small.s-align-text-bottom span.a-icon-alt").text == "Prime"
      page_item_hash[:prime] = true
    else
      page_item_hash[:prime] = false
    end

    puts page_item_hash[:prime]
    page_item_hash[:rating] = amazon_noto_item.css("i.a-icon-star span.a-icon-alt").text
    puts page_item_hash[:rating]
    page_item_hash[:link] = amazon_noto_item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal").attribute('href').value


    amazon_item = AmazScrape::Amazon_Item.new(page_item_hash)

    amazon_item
  end

  def scrape
    if item_valid?

      item_list = []

      @amazon_noto_item_list.each do |amazon_noto_item|
        item_list << read_item(amazon_noto_item)
      end

      item_list
    end
    puts "There were no results!"
  end
end
