class InvitationsController < ApplicationController
  def create
    @invitation = Invitation.new(invitation_params)
    if !Invitation.find_by(invitable_type: invitation_params[:invitable_type], invitable_id: invitation_params[:invitable_id])
      @invitation.save
    end
    redirect_to group_path(Group.find(invitation_params[:invitable_id]))
  end

  def destroy
    Invitation.find(params[:invitation][:id]).destroy
    redirect_to root_path
  end

  private
  def invitation_params
    params.require(:invitation).permit(:sender_id, :recipient_id, :invitable_type, :invitable_id, :description)
  end
end