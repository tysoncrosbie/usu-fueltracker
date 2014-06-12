class Plane < ActiveRecord::Base
  extend FriendlyId

  has_many :receipts

  friendly_id :tail_number, use: [:slugged, :history]

## VALIDATIONS
  validates :tail_number, presence: true, uniqueness: true
  validates :plane_type, presence: true
  validates_inclusion_of :fuel_type, :in => ['Jet Fuel', 'AV Fuel']

## State Machine
  state_machine :status, initial: :active do
    event :activate do
      transition any => :active
    end
    event :inactivate do
      transition any => :inactive
    end
  end

## Scopes
  self.state_machines[:status].states.collect(&:name).each do |name|
    scope name.to_sym, -> { where(status: name) }
  end



end

