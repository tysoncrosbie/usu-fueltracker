class Airport < ActiveRecord::Base

  has_many :receipts

  before_save :uppercase_faa
  before_save :uppercase_state


## Scopes
  scope :utah_airports,         -> { where('id IS NOT NULL AND state = ?', 'UT') }
  scope :out_of_state_airports, -> { where('id IS NOT NULL AND state != ?', 'UT') }


## Validations
  validates :faa_code, :city, :state, :airport_name, presence: true
  validates :faa_code, length: {minimum: 3, maximum: 4}, uniqueness: true

private

  def uppercase_faa
    self.faa_code.upcase!
  end

  def uppercase_state
    self.state.upcase!
  end
end
