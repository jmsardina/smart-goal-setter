require 'open-uri' 
require 'nokogiri'

NAMES = ["Chris", "Skylar", "Jennifer", "Cyrus", "John", "Yohana", "Yomaira",
"Luis", "Georgie", "Stephanie", "Keren", "Angelina", "Manuel", "Sebastian", "Steve", "Simone", "Avi", "Antonio", "Mara", "Charles", "Alicia", "Daniel", "Eryca"]

def emails    
  base_string = "person_0@example.com"   
  (1..20).collect{|number| base_string.gsub("0", number.to_s)}   
end

EMAILS = emails

TAGS = ["health", "spirit", "finance", "education",
"personal", "relationship", "work", "intelectual", "political", "weight-loss",
"smoking", "alcohol", "children", "family"].sort!

def create_tags   
  TAGS.each{|tag| Tag.create(name: tag)} 
end

GROUP_NAMES = [
  {"Weight-aThon" => ["Getting Healthier, one pound-at-a-time", [Tag.take(2)]]}, 
  {"The Flatiron Students" => ["Becoming Junior Programmers in 12 weeks!", [Tag.take(2)]]},
  {"The Locals" => ["Let's visit every street in New York City by the end of 2016!",[Tag.take(2)]]},
  {"Cleaners of Tomorrow" => ["Fellow humans trying to keep a tidier home", [Tag.take(2)]]},
  {"Family Matters" => ["Let's treat our loved ones with respect they deserve", [Tag.take(2)]]}]

def create_groups
  GROUP_NAMES.each do |name, attributes| 
    user = User.find(rand(1..5))
    user.groups <<  Group.create(name: name, description: attributes.first, tags: attributes.last)
    user.save
  end
end

# BEGIN GOALS
lang_goal = Goal.create(
  name: "French", 
  description: "Become conversationally proficient in French in 6 months", 
  due_date: 6.months.from_now,
  motivation: "I'm traveling to France in November", 
  potential_barrier: "I don't know how I'll find the time", 
  coping_strategy: "Using Goaly!", 
  support: "My friend so-and-so is learning with me.", 
  activities:
    Activity.create([
      {
        description: "Practice Duolingo", 
        period: "day", 
        barrier: "I feel like I don't have time.", 
        facilitator: "Jennifer will always be there cheering me on!"
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

exercise_goal = Goal.create(
  name: "Exercise", 
  description: "Exercise 3x/week for the next 3 months", 
  due_date: "2015-07-15T".to_date, 
  motivation: "I want to go hiking this summer", 
  potential_barrier: "I don't know how I'll find the time", 
  coping_strategy: "Using Goaly!", 
  support: "My friend so-and-so is doing this with me.", 
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
# END GOALS

def create_users(lang_goal, exercise_goal)   
  index = 0   
  
  while index < EMAILS.length     
    User.create(name: NAMES.sample, email: EMAILS[index], password: "password123", goals: [lang_goal, exercise_goal])     
    index += 1
  end 
end

def scrape_quotes(link, css_selector, language)   
  html = open(link)   
  doc = Nokogiri::HTML(html)

  doc.css(css_selector).each{|quote| MotivationalQuote.create(content: quote.text, language: language)} 
end

#SEED MOTIVATIONAL QUOTES 
(1..9).map{|num| scrape_quotes(("http://www.brainyquote.com/quotes/topics/topic_motivational" +
"#{num}"), 'span a', "English")}


# create_users(lang_goal, exercise_goal)
# create_tags
# create_groups
