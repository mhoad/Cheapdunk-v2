# == Schema Information
#
# Table name: reviews
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  venue_id   :integer
#  comment    :text
#  rating     :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Review < ActiveRecord::Base
attr_accessible :comment, :rating, :user_id, :venue_id

  belongs_to :user
  belongs_to :venue

  validates :comment, presence: true, length:{ maximum: 500, minimum: 100 }
  validates :user_id, presence: true
  validates :venue_id, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
