class HomeworkWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly(1) }

  def perform
    HomeworkNotification.call_notifications
  end
end
