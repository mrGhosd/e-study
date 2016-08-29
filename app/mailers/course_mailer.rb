class CourseMailer < ActionMailer::Base
  default from: 'support@estudy.edu'

  def test(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def timer
    binding.pry
    mail(to: 'vforvad@gmail.com', subject: 'Timer test')
  end
end
