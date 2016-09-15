class HomeworkWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly(1) }

  def perform
    courses = Course.where(active: true)
    courses.each do |course|
      students = course.students
      parse_lessons(course, students)
    end
  end

  private

  def parse_lessons(course, students)
    lessons = course.lessons.where(active: true)
    lessons.each_with_index do |lesson, index|
      if lesson.repeated
        finished = lesson.end_date < Time.zone.now
        lesson_finished(lesson, course, students) if finished
      else
        next_lesson = lessons[index + 1]
        finished = lesson.end_date < Time.zone.now
        non_repeated_lesson_finixhed(lesson, next_lesson, course, students) if finished
      end
    end
  end

  def non_repeated_lesson_finixhed(prev_lesson, next_lesson, course, students)
    next_lesson_date = next_lesson&.begin_date || prev_lesson.begin_date + 1.week
    students.each do |student|
      date_diff = next_lesson_date - Time.zone.now
      send_notification(course, next_lesson, student, date_diff)
    end
  end

  def lesson_finished(lesson, course, students)
    next_lesson_date = Time.zone.now + lesson.period.day
    students.each do |student|
      date_diff = next_lesson_date - Time.zone.now
      send_notification(course, lesson, student, date_diff)
    end
  end

  def valid_date(date_diff)
    date_diff.positive? && date_diff <= 7.days
  end

  def send_notification(course, lesson, student, date_diff)
    HomeworkMailer.notification(course, lesson, student).deliver_now if valid_date(date_diff)
  end
end
