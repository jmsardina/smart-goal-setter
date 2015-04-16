class Invitation < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  belongs_to :invitable, polymorphic: true

  def pending?
    self.status == "pending"
  end

  def accepted?
    self.status == "accepted"
  end

  def declined?
    self.status == "declined"
  end
end
