# require 'carrierwave/orm/activerecord'

class Receipt < ActiveRecord::Base

  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
end
