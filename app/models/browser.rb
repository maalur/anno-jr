class Browser < ActiveRecord::Base
	belongs_to :user
	has_many :views, foreign_key: "linker_id", dependent: :destroy
	has_many :linked_tracks, through: :views, source: :linked
	default_scope -> { order('created_at DESC') }
	validates :name, presence: true
	validates :user_id, presence: true
	validates :genome, presence: true
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

  @@default_configs = {
  	'dna methylation' => {
  		iconCls: 'salk_meth',
  		height: 40,
  		scale: 1
  	},
  	'annotation models' => {
  		iconCls: 'silk_bricks',
  		height: 100,
  		scale: 1,
  		showControls: 1
  	},
  	'messenger rna' => {
  		iconCls: 'salk_mrna',
			height: 40,
			scale: 0.25
  	},
  	'homologous regions' => {
  		iconCls: 'silk_bricks',
			height: 10,
			single: 1,
  	},
  	'reads' => {
  		iconCls: 'salk_dna',
			height: 40,
			scale: 1,
  	}
  }

  def generate_config(tracks)
  	{
  		tracks: tracks.map do |track|
  			{
  				id: track.id.to_s,
  				name: track.name,
  				type: track.track_type,
  				path: track.path,
  				data: "/tracks/#{track.id}.json",
  			}.merge(@@default_configs[track.path.downcase])
  		end,
  		active: tracks.map(&:id),
  		title: self.name,
  		genome: "/browsers/#{self.id}/genome.json",
  		location: {
				assembly: '1',
				position: '650721',
				bases: 80,
				pixels: 1,
			}, #make dynamic
			admin: {
				name:  self.user.name,
				email: self.user.email,
				notes: ''
			},
			settings: { yaxis: 100 },
			citation: ''
  	}
  end
end
