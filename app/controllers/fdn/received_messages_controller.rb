class Fdn::ReceivedMessagesController < ApplicationController
  # GET /fdn/received_messages
  # GET /fdn/received_messages.json
  def index
    @fdn_received_messages = Fdn::ReceivedMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fdn_received_messages }
    end
  end

  # GET /fdn/received_messages/1
  # GET /fdn/received_messages/1.json
  def show
    @fdn_received_message = Fdn::ReceivedMessage.find(params[:id])
    @fdn_received_message.be_read(current_user)
    @msg_count = current_user.inbox_messages.unread.size
    @tab_idx = params[:tab_idx]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fdn_received_message }
    end
  end

  # GET /fdn/received_messages/new
  # GET /fdn/received_messages/new.json
  def new
    @fdn_received_message = Fdn::ReceivedMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fdn_received_message }
    end
  end

  # GET /fdn/received_messages/1/edit
  def edit
    @fdn_received_message = Fdn::ReceivedMessage.find(params[:id])
  end

  # POST /fdn/received_messages
  # POST /fdn/received_messages.json
  def create
    @fdn_received_message = Fdn::ReceivedMessage.new(params[:fdn_received_message])

    respond_to do |format|
      if @fdn_received_message.save
        format.html { redirect_to @fdn_received_message, notice: 'Received message was successfully created.' }
        format.json { render json: @fdn_received_message, status: :created, location: @fdn_received_message }
      else
        format.html { render action: "new" }
        format.json { render json: @fdn_received_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fdn/received_messages/1
  # PUT /fdn/received_messages/1.json
  def update
    @fdn_received_message = Fdn::ReceivedMessage.find(params[:id])

    respond_to do |format|
      if @fdn_received_message.update_attributes(params[:fdn_received_message])
        format.html { redirect_to @fdn_received_message, notice: 'Received message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fdn_received_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fdn/received_messages/1
  # DELETE /fdn/received_messages/1.json
  def destroy
    @fdn_received_message = Fdn::ReceivedMessage.find(params[:id])
    #@fdn_received_message.destroy
    @fdn_received_message.be_trashed(current_user)

    respond_to do |format|
      format.html { redirect_to fdn_messages_url }
      format.json { head :no_content }
    end
  end
end
