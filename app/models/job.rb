class Job < ActiveRecord::Base
	belongs_to :company
	has_many :resume
	validates :name,:company, :description, :category, presence: true
end

