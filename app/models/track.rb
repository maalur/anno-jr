class Track < ActiveRecord::Base
	belongs_to :user
	has_many :reverse_views, foreign_key: "linked_id",
                                   class_name:  "View",
                                   dependent:   :destroy
  has_many :linkers, through: :reverse_views, source: :linker
	default_scope -> { order('created_at DESC') }
	validates :name, presence: true
	validates :user_id, presence: true
	self.per_page = 10
end
