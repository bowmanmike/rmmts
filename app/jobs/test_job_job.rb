class TestJobJob < ActiveJob::Base
  queue_as :default

  def perform
    # chore.frequency = rand(20)
    # chore.save
    puts "I DO A THING MULTIPLE TIMES APPARENTLY"
  end
end
