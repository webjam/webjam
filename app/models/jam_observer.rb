class JamObserver < ActiveRecord::Observer
  def before_create(jam)
    if jam.proposing_user_id
      # need to add the user.
      user = User.find(jam.proposing_user_id)
      jam.users << user
    end
  end
end
