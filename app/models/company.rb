class Company < ActiveRecord::Base
	has_many :jobs, dependent: :destroy
	validates :name, uniqueness: true, presence: true
	validates :country, :city, presence: true
end


