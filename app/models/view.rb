class View < ActiveRecord::Base
	belongs_to :linker, class_name: "Browser"
  belongs_to :linked, class_name: "Track"
  validates :linker_id, presence: true
  validates :linked_id, presence: true
end
