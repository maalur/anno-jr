class Track < ActiveRecord::Base
	belongs_to :user
	has_many :reverse_views, foreign_key: "linked_id",
                                   class_name:  "View",
                                   dependent:   :destroy
  has_many :linkers, through: :reverse_views, source: :linker
	default_scope -> { order('created_at DESC') }
	validates :name, presence: true
	validates :user_id, presence: true
	validates :track_type, presence: true
	validates :path, presence: true
	validates :data, presence: true
	self.per_page = 10

  def annoj_data(params)
  	annoj_params = params.select { |k,v| !['id', 'action', 'controller', 'format'].include?(k) }
  	annoj_params['action'] = params['annoj'] ? params['annoj'][0]['action'] : nil
		open(self.data + "?" + URI.encode_www_form(annoj_params)).read
	end

end
