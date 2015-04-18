class MotivationalQuote < ActiveRecord::Base
  validates :content, :language, presence: true
  validates :content, uniqueness: true
end
