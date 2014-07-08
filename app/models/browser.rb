class Browser < ActiveRecord::Base
	belongs_to :user
	has_many :views, foreign_key: "linker_id", dependent: :destroy
	has_many :linked_tracks, through: :views, source: :linked
	default_scope -> { order('created_at DESC') }
	validates :name, presence: true
	validates :user_id, presence: true
	self.per_page = 10

	def linked?(track)
		views.find_by(linked_id: track.id)
	end

	def link!(track)
		views.create!(linked_id: track.id)
	end

	def unlink!(track)
    views.find_by(linked_id: track.id).destroy
  end
end
