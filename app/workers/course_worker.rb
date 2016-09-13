class CourseWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly(1) }

  def perform
    inactive_courses
  end

  private

  def disable_latest_courses
    Course.where('end_date < ?', Time.zone.now).update_all(active: false)
  end
end
