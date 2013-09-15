class Admin::LogEntriesController < ApplicationController

  before_action :signed_in_user
  before_action :authorize

  def index
    @log_entries = LogEntry.newest.to_a
  end

  private

    def authorize
      redirect_to(root_url) unless current_user.can_manage_worlds?
    end
end