class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show]
  after_action :log_search, only: %i[search]

  # GET /articles or /articles.json
  def index; end

  def search
    # if no params, no results
    @articles = if params[:search].present?
                  Article.search_articles(params[:search])
                else
                  Article.none
                end
    # turbo stream allows realtime search
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'results', partial: 'articles/results', locals: { articles: @articles }
        )
      end
    end
  end

  # GET /articles/1 or /articles/1.json
  def show; end

  private

  def log_search
    # no point in logging empty strings
    return if params[:search].blank?

    # read cache or write if missing
    scheduled_job_id = Rails.cache.fetch('scheduled_job_id', expires_in: 5.minutes) do
      # when it performs, cache expires
      LogJob.perform_in(5.minutes, { ip: request.remote_ip, input: params[:search] }.to_json)
    end
    # find job in schedule
    scheduled_job = Sidekiq::ScheduledSet.new.find_job(scheduled_job_id)
    cached_input = JSON.parse(scheduled_job.args.first)['input']

    # returns if search has nothing new
    return if cached_input.include? params[:search]

    # if current search expands recent search
    if params[:search].include? cached_input
      # kills scheduled job
      Rails.cache.delete('scheduled_job_id')
      scheduled_job.kill
    # current search is different and not an expansion = new search
    else # if params[:search] != cached_input
      # runs scheduled job now, saving the completed search
      Rails.cache.delete('scheduled_job_id')
      scheduled_job.reschedule(Time.now)
    end

    # updates cache with new job
    Rails.cache.write(
      'scheduled_job_id',
      LogJob.perform_in(5.minutes, { ip: request.remote_ip, input: params[:search] }.to_json),
      expires_in: 5.minutes
    )
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:search)
  end
end
