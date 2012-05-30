# == Schema Information
#
# Table name: venues
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  description    :text
#  street_address :string(255)
#  postcode       :integer
#  suburb         :string(255)
#  url            :string(255)
#  email          :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  phone_number   :string(255)
#  latitude       :float
#  longitude      :float
#

class Venue < ActiveRecord::Base
  attr_accessible :description, :email, :name, :postcode, :street_address, 
                  :suburb, :url, :phone_number, :trading_times_attributes, :specials_attributes

  has_many :trading_times
  has_many :reviews
  has_many :users, :through => :reviews
  has_many :specials

  accepts_nested_attributes_for :trading_times 
  accepts_nested_attributes_for :specials, allow_destroy: true

  #Validations to ensure clean data

  before_save { |venue| venue.email   = email.downcase }
  before_save { |venue| venue.url     = url.downcase }
  before_save { |venue| venue.suburb  = suburb.camelcase }

  VALID_EMAIL_REGEX   = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_URL_REGEX     = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  VALID_SUBURB_REGEX  = /^\w[a-zA-Z ]+$/ #Letters only


  validates :email, allow_blank: true, format: { with: VALID_EMAIL_REGEX }
  validates :url, allow_blank: true, format: { with: VALID_URL_REGEX }
  validates :postcode, presence: true, numericality: true, length:{ is: 4 } #Australian post codes are 4 digits
  validates :suburb, presence: true, format: { with: VALID_SUBURB_REGEX }, length:{ maximum: 20, minimum: 3 }
  validates :description, allow_blank: true, length:{ maximum: 500, minimum: 100 }

  #Geocoding for venues

  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?

  def full_address
    address = "#{self.street_address}, #{self.suburb}, #{self.postcode}, Australia"
  end

  def address_changed?
    street_address_changed? || suburb_changed? || postcode_changed?
  end

end
