class Scraper
  require 'nokogiri'
  require 'open-uri'
  require 'pry'
  AMZ_Websearch = "https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords="

  def scrape_index_page(item_search)
    page_results = []
    item_search.strip!
    item_search.gsub!(/ /, "%20")
    page = Nokogiri::HTML(open(AMZ_Websearch+item_search))

    item_list = page.css("li.s-result-item")
    item_list.each do |item|
      page_item_hash = {}
      name = item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal").text
      print name
      price = item.css("span.a-offscreen").text
      print price
      manufacturer = item.css("div.a-row.a-spacing-none span.a-size-small.a-color-secondary")[1].text
      print manufacturer
      if item.css("i.a-icon.a-icon-prime.a-icon-small.s-align-text-bottom span.a-icon-alt").text == "Prime"
        prime = true
      else
        prime = false
      end
      print prime
      rating = item.css("i.a-icon-star span.a-icon-alt").text
      print rating
      print item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal")
      link = item.css("a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal").attribute('href').value

    end
      #item_name =

  end

  def scrape_item_page(url)
    item_page = Nokogiri::HTML(open(url))
    #features
    #in_stock
    #seller
    #colors
    in_stock = item_page.css("div#availability span.a-size-medium.a-color-success")
    #binding.pry
  end

  def make_items
  end
end

item = Scraper.new
item.scrape_index_page("dutch oven")
item.scrape_item_page("https://www.amazon.com/dp/B01NBICV9C/ref=sspa_dk_detail_2?psc=1")
