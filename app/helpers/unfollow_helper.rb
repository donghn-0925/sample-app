module UnfollowHelper
  def get_relationship 
    current_user.active_relationships.find_by(followed_id: @user.id)
  end
end