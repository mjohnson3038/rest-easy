# require 'carrierwave/orm/activerecord'

class Receipt < ActiveRecord::Base
  belongs_to :user
  has_many :list_items

  validates :user, :presence => true

  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
end
