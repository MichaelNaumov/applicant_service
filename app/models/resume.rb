class Resume < ActiveRecord::Base

	belongs_to :user
	belongs_to :job
	validates :overview, :links_to_projects, :education, presence: true
end
