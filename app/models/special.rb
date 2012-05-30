# == Schema Information
#
# Table name: specials
#
#  id                  :integer         not null, primary key
#  venue_id            :integer
#  name                :string(255)
#  description         :text
#  special_starts_at   :datetime
#  special_finishes_at :datetime
#  available_monday    :boolean
#  available_tuesday   :boolean
#  available_wednesday :boolean
#  available_thursday  :boolean
#  available_friday    :boolean
#  available_saturday  :boolean
#  available_sunday    :boolean
#  end_date            :datetime
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

class Special < ActiveRecord::Base
  attr_accessible :name, :description, :special_starts_at, :special_finishes_at,
                  :available_monday, :available_tuesday, :available_wednesday,
                  :available_thursday, :available_friday, :available_saturday,
                  :available_sunday, :end_date

  belongs_to :venue

  validates :name, presence: true, length:{ maximum: 140, minimum: 3 }
  validates :description, allow_blank: true, length:{ maximum: 300, minimum: 10 }
  validate :custom_checkbox_validation

  def custom_checkbox_validation
    errors.add(:base, "Make sure you select at least 1 day of the week for your special.") unless available_monday || available_tuesday || available_wednesday || available_thursday || available_friday || available_saturday || available_sunday
  end

end
