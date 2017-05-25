class Photo < ApplicationRecord
  attr_accessor :caption_text

  belongs_to :user, optional: true
  belongs_to :team

  has_one :caption
  has_attached_file :image, styles: { preview: ["200x200#", :jpg] }

  validates_attachment :image, presence: true,
                      content_type: {
                        content_type: ["image/jpeg",
                          "image/gif",
                          "image/png"]
                      }

  after_save :save_caption

  # ------ Instance Methods ------
  def destroy
    self.caption.destroy
    super
  end

  def save_caption
    captn = Caption.new(:text => caption_text, :photo_id => self.id)
    captn.save
  end
end
