class Couple < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :goals, dependent: :destroy

  validates :partner_1, :partner_2, presence: true

  before_validation :generate_slug

  #override id -> slug
  def to_param
    slug
  end

  def partner_1_first_name
    partner_1.split.first
  end

  def partner_2_first_name
    partner_2.split.first
  end

  private

  def generate_slug
    return unless partner_1.present? && partner_2.present?
    self.slug = "#{partner_1.split.first}-e-#{partner_2.split.first}".parameterize
  end
end
