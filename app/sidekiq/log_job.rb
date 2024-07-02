class LogJob
  include Sidekiq::Job

  sidekiq_options retry: 5

  def perform(data)
    Log.create(ip: data[:ip], input: data[:input])
  end
end
