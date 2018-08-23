class Course < ApplicationRecord
	has_many :enrollments
	has_many :users, :through => :enrollments
	has_many :course_subjects
	has_many :subjects, :through => :course_subjects

	def self.search(params)
		if !params[:keywords].empty? && !params[:subject].empty?
			return Course.includes(:course_subjects).where('course_subjects.subject_id = ? AND lower(name) LIKE ?', params[:subject], "%#{params[:keywords]}%".downcase).references(:course_subjects).order(:name)
		elsif params[:keywords].empty? && !params[:subject].empty?
			return Course.includes(:course_subjects).where('course_subjects.subject_id = ?', params[:subject]).references(:course_subjects).order(:name)
		elsif !params[:keywords].empty? && params[:subject].empty?
			return Course.where("lower(name) LIKE ?", "%#{params[:keywords]}%".downcase).order(:name)
		else		
			return Course.all.order(:name)
		end
	end
end
