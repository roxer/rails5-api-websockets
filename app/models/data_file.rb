class DataFile < ApplicationRecord
  mount_uploader :menu, DataFileUploader
  mount_uploader :dish, DataFileUploader
  mount_uploader :menu_item, DataFileUploader
  mount_uploader :menu_page, DataFileUploader
end