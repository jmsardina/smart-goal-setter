require 'open-uri' 
require 'nokogiri'

NAMES = ["Chris", "Skylar", "Jennifer", "Cyrus", "John", "Yohana", "Yomaira",
"Luis", "Georgie", "Stephanie", "Keren", "Angelina", "Manuel", "Sebastian", "Steve", "Simone", "Avi", "Antonio", "Mara", "Charles", "Alicia", "Daniel", "Eryca"]

def emails    
  base_string = "person_0@example.com"   
  (1..20).collect{|number| base_string.gsub("0", number.to_s)}   
end

# # PICTURES = ["http://i.istockimg.com/cms/resources/images/HomePage/Tiles/US%20April/baby-70218269.jpg",
# "http://i.istockimg.com/file_thumbview_approve/18070301/2/stock-photo-18070301-mother-and-daughter.jpg",

# # ]
EMAILS = emails

def create_users
  index = 0   
  
  while index < EMAILS.length     
    User.create(name: NAMES.sample, email: EMAILS[index], password: "password123", image_url: "http://lorempixel.com/400/400/people/")     
    index += 1
  end 
end

TAGS = ["health", "spirit", "finance", "education",
"personal", "relationship", "work", "intelectual", "political", "weight-loss",
"smoking", "alcohol", "children", "family", "professional", "fitness", "adventurous", "leisure"].sort!

def create_tags   
  TAGS.each{|tag| Tag.create(name: tag)} 
end

GROUP_NAMES = [
  {"Biggest Losers" => ["Getting Healthier, one pound-at-a-time", 
    [Tag.find_by(name: "fitness"), Tag.find_by(name: "weight-loss"), Tag.find_by(name: "health")]
    ]
  }, 
  {"The Flatiron Students" => ["Becoming Junior Programmers in 12 weeks!", 
    [Tag.find_by(name: "intelectual"), Tag.find_by(name: "professional")]
    ]
  },
  {"The Locals" => ["Let's visit every street in New York City by the end of 2016!",
    [Tag.find_by(name: "adventurous"), Tag.find_by(name: "leisure")]
    ]
  },
  {"Cleaners of Tomorrow" => ["Fellow humans trying to keep a tidier home", 
    [Tag.find_by(name: "personal")]
    ]
  },
  {"Family Matters" => ["Let's treat our loved ones with respect they deserve", 
  [Tag.find_by(name: "family"), Tag.find_by(name: "relationship")]
    ]
  },
  {"Team FitBody" => ["Aiming for a great body this Christmas!", 
    [Tag.find_by(name: "fitness"), Tag.find_by(name: "health")]
    ]
  }
]

def create_groups
  GROUP_NAMES.each do |group_hash|
    group_hash.each do |name, info| 
      group = Group.create(name: name, description: info[0], creator_id: User.all.sample.id, image_url: "http://lorempixel.com/400/400/abstract/")
      group.boards << Board.create(name: "Main")
      info.last.each do |tag|
        group.tags << tag
      end
      group.members << User.take(7)
      group.save
    end
  end
end
# def create_groups
#   GROUP_NAMES.each do |name, attributes| 
#     user = User.find(rand(1..5))
#     user.groups <<  Group.create(name: name, description: attributes.first, tags: attributes.last)
#     user.save
#   end
# end

# # BEGIN GOALS
# LANGUAGE GOAL
User.all.each do |user| 
  Goal.create(
    name: "French", 
    description: "Become conversationally proficient in French in 6 months", 
    due_date: 6.months.from_now,
    motivation: "I'm traveling to France in November", 
    potential_barrier: "I don't know how I'll find the time", 
    coping_strategy: "Using Goaly!", 
    support: "My friend so-and-so is learning with me.", 
    user_id: user.id,
    activities:
      Activity.create([
        {
          description: "Practice Duolingo", 
          period: "day", 
          barrier: "I feel like I don't have time.", 
          facilitator: "Jennifer will always be there cheering me on!",
          
        }, 
        {
          description: "Have a conversation with a native speaker",
          period: "month", barrier: "I'm shy", 
          facilitator: "I'm friendly", 
          frequency: 2
        }, 
        {
          description: "Watch foreign-language TV", 
          period: "week", 
          barrier: "The weather is getting nice and I might not want to watch TV.", 
          facilitator: "???", 
          frequency: 1
          }, 
          {
            description: "Read in the language", 
            period: "week",
            barrier: "The readings out there are difficult.", 
            facilitator: "I will make sure that I understand one reading before moving on to the next.", 
            frequency: 2
          }
        ])
    )

#FITNESS GOAL
  Goal.create(
    name: "Exercise", 
    description: "Exercise 3x/week for the next 3 months", 
    due_date: "2015-07-15T".to_date, 
    motivation: "I want to go hiking this summer", 
    potential_barrier: "I don't know how I'll find the time", 
    coping_strategy: "Using Goaly!", 
    support: "My friend so-and-so is doing this with me.", 
    user_id: user.id,
    activities: 
      Activity.create(
        [{
            description: "Do yoga",
            period: "week", 
            barrier: "I feel like I don't have time.", 
            facilitator: "Jennifer will always be there cheering me on!", 
            frequency: 3
          },
          {
            description: "Go for a walk outside", 
            period: "week", 
            barrier: "It's very rainy", 
            facilitator: "I can ask a friend to come with.", 
            frequency: 7
          },
          {
            description: "Do strength-training in the gym", 
            period: "week", 
            barrier: "I don't like strength-training that much.", 
            facilitator: "???", 
            frequency: 4
          }
        ]
      )
    )
end

# GENERIC_COMMENTS = ["This challenge has been more difficult than I expected...", "What has been the most difficult part of this challenge?", "I would say the best thing to do is to stay positive!", "It's not helpful to compare yourself with other people -- look at how far you've come.", "I am so glad I found such an amazing group of people..."]

# GENERIC_COMMENTS.each do |content|
#   Board.all.each do |board|
#     # Comment.all.each do |comment|
#       Comment.create(content: content, user_id: User.all.sample.id, commentable_type: board.class.name, commentable_id: board.id)
#     # end
#   end
# end

def scrape_quotes(link, css_selector, language)   
  html = open(link)   
  doc = Nokogiri::HTML(html)

  doc.css(css_selector).each{|quote| MotivationalQuote.create(content: quote.text, language: language) if quote.text.length > 10} 
end

#SEED MOTIVATIONAL QUOTES 
(1..9).map{|num| scrape_quotes(("http://www.brainyquote.com/quotes/topics/topic_motivational" +
"#{num}"), 'span a', "English")}


create_tags
create_users
create_groups
