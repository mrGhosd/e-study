class LessonWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily(1) }

  def perform
    CourseMailer.timer.deliver_now
  end
end
