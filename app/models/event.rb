class Event < ApplicationRecord
  belongs_to :couple
  has_many_attached :images

  validate :image_format


  private

  def image_format
    images.each do |image|
      unless image.content_type.in?(%w[image/png image/jpg image/jpeg])
        errors.add(:images, 'somente arquivos PNG, JPG ou JPEG são permitidos')
      end
      errors.add(:images, 'cada imagem deve ter menos de 5MB') if image.byte_size > 5.megabytes
    end
  end
end
