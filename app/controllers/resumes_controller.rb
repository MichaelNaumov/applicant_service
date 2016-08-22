require 'will_paginate/array' 

class ResumesController < ApplicationController

	before_action :authenticate_user!
	before_filter :find_company, only: [:show, :edit, :update, :destroy]

	def index
		@resumes = Resume
		@resumes = @resumes.paginate(per_page: 10, page: params[:page])
	end

	def show		
		@resume = Resume.find(params[:id])
	end

	def new
		@resume = Resume.create
	end

	def create	
		@job = Job.find(params[:job_id])	
		@resume = @job.resumes.new(resume_params)

		if @resume.errors.empty?
			@resume.save
			redirect_to job_resumes_path 
		else 
			render "new"
		end
	end

	def edit		
	end

	def update		
		@resume.update_attributes(resume_params)
		if @resume.errors.empty?
			redirect_to resume_path
		else
			render "edit"
		end
	end

	def destroy		
		@resume.destroy
		redirect_to job_resumes_path
	end
	
	def resume_params		
		params.require(:resume).permit(:overview, :job_id, :links_to_projects, :education)
	end

	private

		def find_resume
			@resume = Resume.find(params[:id])
		end

end
