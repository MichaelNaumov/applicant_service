class Job < ActiveRecord::Base
	belongs_to :company
	validates :name,:company, :description, :category, presence: true
end

