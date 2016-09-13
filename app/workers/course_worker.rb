class CourseWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly.minute_of_hour(0, 10, 20, 30, 40, 50) }

  def perform
    disable_latest_courses
  end

  private

  def disable_latest_courses
    Course.where('end_date < ?', Time.zone.now).update_all(active: false)
  end
end
