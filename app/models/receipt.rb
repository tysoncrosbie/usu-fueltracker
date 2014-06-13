class Receipt < ActiveRecord::Base
  extend FriendlyId

## Associations
  belongs_to :plane
  belongs_to :airport
  has_many :non_fuel_charges, dependent: :destroy


  friendly_id :receipt_number, use: [:slugged, :history]
  accepts_nested_attributes_for :non_fuel_charges, allow_destroy: true

## State Machine
  state_machine :status, initial: :pending do
    event :verify do
      transition any => :verified
    end
    event :pend do
      transition any => :pending
    end
  end

## Scopes
  self.state_machines[:status].states.collect(&:name).each do |name|
    scope name.to_sym, -> { where(status: name) }
  end
  scope :in_report, -> (starts_on, ends_on) { where('receipt_date BETWEEN ? AND ?', starts_on, ends_on) }

## Validations
  validates :receipt_number, :receipt_date, :vendor_name, presence: true
  validates :gallons, :fuel_cost, presence: true, numericality: true

end
