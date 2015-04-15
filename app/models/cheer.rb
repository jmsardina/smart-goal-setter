class Cheer < ActiveRecord::Base
  belongs_to :cheerable, polymorphic: true
  belongs_to :user

  # def cheered_already?
  #   !!Cheer.find_by(user_id: current_user.id, cheerable_type: cheer_params[:cheerable_type], cheerable_id: cheer_params[:cheerable_id])
  # end
end
