class Caption < ApplicationRecord
  belongs_to :photo
  validates :text, presence: true

  def text_preview
    if text.length > 15
      text.slice(0, 15) + '...'
    else
      text
    end
  end
end
