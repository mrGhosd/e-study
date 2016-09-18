class LessonWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly(1) }

  def perform
    Lesson.where('end_date < ?', Time.zone.now).update_all(active: false)
    update_repeated_lessons
  end

  private

  def update_repeated_lessons
    ActiveRecord::Base.transaction do
      Lesson.where(repeated: true, active: false).each do |lesson|
        begin_date = lesson.begin_date + lesson.period.days
        end_date = lesson.end_date + lesson.period.days
        lesson.update!(begin_date: begin_date, end_date: end_date)
      end
    end
  end
end
