class LessonWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly(1) }

  def perform
    CourseMailer.timer.deliver_now
  end
end
