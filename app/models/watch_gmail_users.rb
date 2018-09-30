# frozen_string_literal: true

class WatchGmailUsers
  def perform
    GmailWatch.in_batches.each do |batch|
      batch.pluck(:authentication_id).each do |authentication_id|
        Delayed::Job.enqueue WatchGmailUser.new(authentication_id)
      end
    end
  end
end
