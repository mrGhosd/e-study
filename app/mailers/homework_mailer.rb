class HomeworkMailer < ActionMailer::Base
  default from: 'support@estudy.edu'

  def notification(course, lesson, user)
    @course = course
    @lesson = lesson
    @user = user
    mail(to: @user.email, subject: "#{course.title} #{lesson.title} homework notification")
  end
end
