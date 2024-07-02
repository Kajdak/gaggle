class SearchJob
  include Sidekiq::Job

  sidekiq_options retry: 5

  def perform(search)
  end
end
