class Cheer < ActiveRecord::Base
  belongs_to :cheerable, polymorphic: true
  belongs_to :user
end
