class Couple < ApplicationRecord
  belongs_to :user
  
  has_one :savings_table, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :goals, dependent: :destroy

  validates :partner_1, :partner_2, presence: true

  before_validation :generate_slug
  after_create :create_saving_table

  # override id -> slug
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
  
    base_slug = "#{partner_1.split.first}-e-#{partner_2.split.first}".parameterize
    new_slug = base_slug
    count = 2
  
    while Couple.exists?(slug: new_slug)
      new_slug = "#{base_slug}-#{count}"
      count += 1
    end
  
    self.slug = new_slug
  end

  def create_saving_table
    SavingsTable.create(couple: self)
  end
  
end
