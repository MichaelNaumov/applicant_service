require 'will_paginate/array' 

class JobsController < ApplicationController

 	before_action :authenticate_user!
	before_filter :find_job, only: [:show, :edit, :update, :destroy]

	def index
		@jobs = Job
		order = params[:order] == "asc" ? "asc" : "desc"
		@jobs = @jobs.order("name #{order}")
		@jobs = @jobs.paginate(per_page: 10, page: params[:page])
	end

	def show		
		@job = Job.find(params[:company])
		render_template(:file => "#{Rails.root}/public/404.html") unless @job.company_id == params[:company_id]
	end

	def new
  		@job = Job.new
	end

	def create		
		@company = Company.find(params[:company_id])
		  @job = @company.jobs.new(job_params)
		  if @job.errors.empty?
		  	@job.save
		    redirect_to company_jobs_path
		  else 
		  	render "new"
		  end 
	end

	def edit		
	end

	def update		
		@job.update_attributes(job_params)
		if @job.errors.empty?
			redirect_to @job
		else
			render "edit"
		end
	end

	def destroy		
		@job.destroy
		redirect_to companies_path
	end

	def job_params		
		params.require(:job).permit(:name, :company_id, :description, :category, :deadline)
	end

	private

		# def has_admin_privileges?
		# 	redirect_to "/users/sign_in" unless current_user			
		# 	render(file: "public/403.html", status: "403.html") unless current_user.admin
		# end

		def find_job
			@job = Job.find(params[:id])
		end

end
