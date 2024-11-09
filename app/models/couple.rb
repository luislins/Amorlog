class Couple < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy

  def to_param
    slug
  end
end
