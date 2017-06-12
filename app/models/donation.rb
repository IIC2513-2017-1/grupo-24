class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :ammount, presence: true

  after_save :check_achievement

  def check_achievement
    if !project.achieve && project.donations.sum(&:ammount) >= project.goal
      project.update(achieve: true)
      project.donations.group_by {|don| don.user_id}.each do |user, donation|
        DonatorMailer.goal_achieved(project, donation.first.user).deliver_now
      end
    end
  end
end
