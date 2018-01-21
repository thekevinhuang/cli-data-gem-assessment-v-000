require_relative "../amaz_scrape.rb"

class AmazScrape::Scraper
  AMZ_Websearch = "https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords="
  attr_accessor :item, :scraped_items
  #attr_reader :name, :price, :manufacturer, :prime, :rating, :item_list

  def initialize(item)
    @item = item
    @amazon_noto_item_list = []
    @scraped_items = []
  end


  def item_valid?
    
    validation = false

    @item.strip!
    @item.gsub!(/ /, "%20")
    begin

      io_item = open(AMZ_Websearch+@item)
      connection_status = io_item.status[0]
      
      @page = Nokogiri::HTML(io_item)
      
      @amazon_noto_item_list = @page.css("body li.s-result-item")[0..9]
      puts @amazon_noto_item_list.length

    rescue OpenURI::HTTPError => connection_error
      connection_status = connection_error.io.status[0]
      puts "Scraping instance failed with code #{connection_status}"
      sleep 5
      item_valid?
    end

    if !@amazon_noto_item_list.empty?
      validation = true
    else
      validation = false
    end

    validation
  end

  def detail_scrape(url)

    begin
      io_item = open(url)
      connection_status = io_item.status[0]
      
      @detail_page = Nokogiri::HTML(io_item)
      
      @amz_detail_scrape = @detail_page.css("div#centerCol")

    rescue OpenURI::HTTPError => connection_error
      connection_status = connection_error.io.status[0]
      puts "Scraping instance failed with code #{connection_status}"
      sleep 5
      detail_scrape(url)
    end
    
    page_detail_hash = {}


    #scrapes details on page including:
    
    #features
    #div#feature-bullets
    feature_list = []
    feature_list = @detail_page.css("div#feature-bullets li span.a-list-item")
    scraped_features = feature_list.collect {|feat| feat.text.strip}
    page_detail_hash[:features] = scraped_features.shift

    #in stock
    #div#availibility
    page_detail_hash[:in_stock] = @detail_page.css("div#availability span").text.strip

    #seller
    #div#merchant-info
    page_detail_hash[:seller] = @detail_page.css("div#merchant-info").text.split.join(" ").strip

    #colors
    if if_not_nil(@detail_page.css("div#variation_color_name ul li"))
      colors = @detail_page.css("div#variation_color_name ul li").collect do |item_color|
        item_color.attr("title").split.last
      end

      page_detail_hash[:colors] = colors
      page_detail_hash
    end
    #check if exists
    #div#variation_color_name
  end

  def read_item(amazon_noto_item)
    #page_item_hash = {}

    #need to be careful about the usage of .text because certain types will error out
    #implement an array empty check for this

    #create blank hash to store scraped information
    page_item_hash = {}

    #scrape name and store
    if if_not_nil(amazon_noto_item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal"))
      page_item_hash[:name] = amazon_noto_item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal").text.strip
      puts page_item_hash[:name]
      
      if page_item_hash[:name].length > 1
        #scrape price and store
        if if_not_nil(amazon_noto_item.css("span.a-offscreen"))
          page_item_hash[:price] = amazon_noto_item.css("span.a-offscreen").text
          puts page_item_hash[:price]
        end

        #scrape maker and store WIP 
        if if_not_nil(amazon_noto_item.css("div.a-row.a-spacing-none:nth-child(2) span.a-size-small.a-color-secondary:nth-child(2)"))
          page_item_hash[:maker] = amazon_noto_item.css("div.a-row.a-spacing-none:nth-child(2) span.a-size-small.a-color-secondary:nth-child(2)").text
        elsif if_not_nil(amazon_noto_item.css("div.a-row.a-spacing-none:nth-child(2) div.a-size-small.a-color-secondary:nth-child(2)"))
          page_item_hash[:maker] = amazon_noto_item.css("div.a-row.a-spacing-none:nth-child(2) div.a-size-small.a-color-secondary:nth-child(2)").text
        end
        puts page_item_hash[:maker]

        #scrape prime and store
        if if_not_nil(amazon_noto_item.css("i.a-icon.a-icon-prime.a-icon-small.s-align-text-bottom span.a-icon-alt"))
          if amazon_noto_item.css("i.a-icon.a-icon-prime.a-icon-small.s-align-text-bottom span.a-icon-alt").text == "Prime"
            page_item_hash[:prime] = true
          else
            page_item_hash[:prime] = false
          end
        end

        puts page_item_hash[:prime]

        #scrape rating and store
        if if_not_nil(amazon_noto_item.css("i.a-icon-star span.a-icon-alt"))
          page_item_hash[:rating] = amazon_noto_item.css("i.a-icon-star span.a-icon-alt").text
          puts page_item_hash[:rating]
        end

        #scrape link for clickthrough
        if if_not_nil(amazon_noto_item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal")) && amazon_noto_item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal").class.method_defined?(:attr)
          if if_not_nil(amazon_noto_item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal").attr("href"))
            page_item_hash[:link] = amazon_noto_item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal").attr('href').value
            puts page_item_hash[:link]
          end
        end
      end
      amazon_item = AmazScrape::Amazon_Item.new(page_item_hash)

      amazon_item
    end
  end

  
  
  def if_not_nil(amazon_item_element_array)
    if !amazon_item_element_array.nil?
      amazon_item_element_array
    end
  end

  def scrape

    if item_valid?

      @amazon_noto_item_list.each do |amazon_noto_item|
        self.scraped_items << read_item(amazon_noto_item)
      end
      self.scraped_items
    else
      puts "There were no results!"
    end
  end
end
