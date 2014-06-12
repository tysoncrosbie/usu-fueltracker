class Report < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: [:slugged, :history]


  scope :utah_tap,          -> { where(type: 'UtahTap') }
  scope :usu_environmental, -> { where(type: 'UsuEnvironmental') }

  validates :name, :starts_on, :ends_on, presence: true
  validates_inclusion_of :type, :in => ['UtahTap', 'UsuEnvironmental']



end

