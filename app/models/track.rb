class Track < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :name, presence: true
	validates :user_id, presence: true
	self.per_page = 10
end
