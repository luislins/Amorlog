class Goal < ApplicationRecord
  belongs_to :couple
  has_many_attached  :images

  validates :title, presence: true
  validates :due_date, presence: true
  validates :kind, presence: true
  validates :current_value, numericality: { greater_than_or_equal_to: 0 }
  validate  :current_value_cannot_exceed_numeric_value
  validate :image_format
  # validate :limit_images

  # validates :image, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes, message: 'deve ter menos de 5MB' }

  enum kind: {
    numeric: 0,
    boolean: 1
  }

  def numeric?
    kind == 'numeric' && numeric_value.present? && current_value.present?
  end

  def mark_as_achieved
    update(achieved: true)
  end

  private

  def current_value_cannot_exceed_numeric_value
    if numeric_value.present? && current_value.present? && current_value > numeric_value
      errors.add(:current_value, "não pode ser maior que o valor da meta (#{numeric_value}).")
    end
  end

  def image_format
    images.each do |image|
      unless image.content_type.in?(%w[image/png image/jpg image/jpeg])
        errors.add(:images, "somente arquivos PNG, JPG ou JPEG são permitidos")
      end
      if image.byte_size > 5.megabytes
        errors.add(:images, "cada imagem deve ter menos de 5MB")
      end
    end
  end

  # def limit_images
  #   if images.count > 1
  #     errors.add(:images, "Você pode adicionar no máximo 5 imagens.")
  #   end
  # end
end
