require 'open-uri' 
require 'nokogiri'

# # PICTURES = ["http://i.istockimg.com/cms/resources/images/HomePage/Tiles/US%20April/baby-70218269.jpg",
# "http://i.istockimg.com/file_thumbview_approve/18070301/2/stock-photo-18070301-mother-and-daughter.jpg",

TAGS = ["health-related", "spiritual", "financial", "educational", "personal", "work-related", "intelectual", "family", "professional"].sort!

def create_tags   
  TAGS.each{|tag| Tag.create(name: tag)} 
end


# def scrape_quotes(link, css_selector, language)   
#   html = open(link)   
#   doc = Nokogiri::HTML(html)

#   doc.css(css_selector).each{|quote| MotivationalQuote.create(content: quote.text, language: language) if quote.text.length > 10} 
# end

# #SEED MOTIVATIONAL QUOTES 
# (1..9).map{|num| scrape_quotes(("http://www.brainyquote.com/quotes/topics/topic_motivational" +
# "#{num}"), 'span a', "English")}


create_tags
create_users
