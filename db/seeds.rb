# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
  # cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
  # Mayor.create(name: 'Emanuel', city: cities.first)

NAMES = ["Chris", "Skylar", "Jennifer", "Cyrus", "John"]
GROUP_NAMES = ["Group 1", "Group 2", "Group 3", "Group 4"]

def emails
  emails = []
  base_string = "person_0@example.com"
  (1..20).each do |number|
    emails << base_string.gsub("0", number.to_s)
  end
  emails
end

EMAILS = emails

def create_users
  index = 0
  while index < EMAILS.length
    User.create(name: NAMES.sample, email: EMAILS[index], password: "password123")
    index += 1
  end
end

3.times do 
  create_users
end

def create_groups
  index = 0
  while index < GROUP_NAMES.length
    Group.create(name: GROUP_NAMES[index])
    index += 1
  end
end

create_groups

def create_user_groups
  UserGroup.create([
    {user_id: 1, group_id: 1},
    {user_id: 2, group_id: 2},
    {user_id: 3, group_id: 3}]
    )
end

create_user_groups


