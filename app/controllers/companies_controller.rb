require 'will_paginate/array' 

class CompaniesController < ApplicationController
	
	before_action :authenticate_user!
	before_filter :find_company, only: [:show, :edit, :update, :destroy]

	def index
		@companies = Company
		order = params[:order] == "asc" ? "asc" : "desc"
		@companies = @companies.order("name #{order}")
		@companies = @companies.paginate(per_page: 10, page: params[:page])
	end

	def show		
	end

	def new
		@company = Company.new
	end

	def create		
		@company = Company.create(company_params)

		if @company.errors.empty?
			redirect_to companies_path
		else 
			render "new"
		end
	end

	def edit		
	end

	def update		
		@company.update_attributes(company_params)
		if @company.errors.empty?
			redirect_to @company
		else
			render "edit"
		end
	end

	def destroy		
		@company.destroy
		redirect_to companies_path
	end

	def company_params		
		params.require(:company).permit(:name, :country, :city)
	end

	private

		# def has_admin_privileges?
		# 	redirect_to "/users/sign_in" unless current_user			
		# 	render(file: "public/403.html", status: "403.html") unless current_user.admin
		# end

		def find_company
			@company = Company.find(params[:id])
		end
end
