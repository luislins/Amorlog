class Couple < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy

  before_validation :generate_slug

  validates :partner_1, :partner_2, presence: true

  def to_param
    slug
  end

  private

  def generate_slug
    # Usa os primeiros nomes para o slug
    self.slug = "#{partner_1.split.first}-e-#{partner_2.split.first}".parameterize if partner_1.present? && partner_2.present?
  end
end
