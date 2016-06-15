class MainController < ApplicationController
  def index
    render layout: 'main'
  end

  def frame_index
    @unread = current_user.inbox_messages.unread
  end
end
