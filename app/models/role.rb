class Role < ActiveRecord::Base
  scopify

## Associations
  belongs_to :resource, polymorphic: true
  has_and_belongs_to_many :users, join_table: :users_roles
end