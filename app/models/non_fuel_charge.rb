class NonFuelCharge < ActiveRecord::Base
  belongs_to :receipt

  validates :student_name, :charge_type, presence: true
  validates :amount, presence: true, numericality: true

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


end
