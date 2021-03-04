class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.where(user: current_user)
  end

  def show
    @sender = current_user
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
    @message = Message.new
  end

end
