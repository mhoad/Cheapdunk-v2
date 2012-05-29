# == Schema Information
#
# Table name: trading_times
#
#  id                  :integer         not null, primary key
#  venue_id            :integer
#  monday_opens_at     :datetime
#  monday_closes_at    :datetime
#  tuesday_opens_at    :datetime
#  tuesday_closes_at   :datetime
#  wednesday_opens_at  :datetime
#  wednesday_closes_at :datetime
#  thursday_opens_at   :datetime
#  thursday_closes_at  :datetime
#  friday_opens_at     :datetime
#  friday_closes_at    :datetime
#  saturday_opens_at   :datetime
#  saturday_closes_at  :datetime
#  sunday_opens_at     :datetime
#  sunday_closes_at    :datetime
#

class TradingTime < ActiveRecord::Base
  attr_accessible :friday_closes_at, :friday_opens_at, :monday_closes_at, :monday_opens_at, :saturday_closes_at, :saturday_opens_at, :sunday_closes_at, :sunday_opens_at, :thursday_closes_at, :thursday_opens_at, :tuesday_closes_at, :tuesday_opens_at, :venue_id, :wednesday_closes_at, :wednesday_opens_at

  belongs_to :venue
end
