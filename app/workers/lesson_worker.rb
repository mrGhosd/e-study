class LessonWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly(1) }

  def perform
    Lesson.where('end_date < ?', Time.zone.now).update_all(active: false)
    # Add support of updated_lessons
  end
end
