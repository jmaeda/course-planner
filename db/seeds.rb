# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Course.destroy_all
Instructor.destroy_all
Subject.destroy_all
CourseSubject.destroy_all

instructors = ActiveSupport::JSON.decode(File.read('db/instructor.json'))
instructors.each do |a|
  Instructor.create({first:a["first"],last:a["last"],email:a["email"]})
end

subjects = ActiveSupport::JSON.decode(File.read('db/subject.json'))
subjects.each do |a|
  Subject.create({name:a["name"],sid:a["id"]})
end

courses = ActiveSupport::JSON.decode(File.read('db/course.json'))
courses.each do |a|
  Course.create({name:a["name"],code:a["code"],description:a["description"]})
  a["subjects"].each do |subject|
  	if(!Subject.find_by(sid: subject["id"]).nil?)
  		CourseSubject.create({course_id: Course.find_by(code: a["code"]).id,subject_id: Subject.find_by(sid: subject["id"]).id})
  	end
  end
end