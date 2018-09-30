require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  handler do |job|
    Delayed::Job.enqueue job.constantize.new
  end

  every(1.day, 'WatchGmailUsers', at: '00:30')
end
