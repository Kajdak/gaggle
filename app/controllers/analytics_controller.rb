class AnalyticsController < ApplicationController
  def index
    @line_data = Log.group(:input).group_by_week(:created_at).count
    @trends = Log.group('input').order('count_id asc').count('id')
  end
end