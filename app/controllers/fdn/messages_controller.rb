#coding: utf-8
module Fdn
  class MessagesController < ApplicationController
    def tree

    end

    def new
      @user_ids = params[:user_ids] ? params[:user_ids].split(',').compact : ""
      @message = Fdn::Message.new(params[:resource])
      @act = params[:act]
      @msg_type =params[:msg_type]||"msg"
      #转发
      if @act == "forward"
        @msg_type = Fdn::Lookup::MSG_TYPE_MSG
        @old_message = Fdn::Message.find(params[:f_id])
        @message.subject = "转发:" + @old_message.subject
        @message.body = "-----------------------\\\n#{@old_message.sender.full_name}:#{@old_message.body}"
      end
      @groups = Fdn::UserGroup.where(:created_by => current_user.id)
      #
      @message.file_resources.build

      @group_opinions = Hash.new
      Fdn::Organization.all.each do |org|
        @group_opinions[org.short_name] = Fdn::User.available.by_org_id(org.id).collect { |x| [x.full_name, x.id] }
      end
      @node = []
      Fdn::Organization.all.each do |org|
        if org.root?
          @node << {id: "o_#{org.id}", pId: "0", name: org.name, class: 'org ', open: true}
        else
          @node << {id: "o_#{org.id}", pId: "o_#{org.parent.id}", name: org.name, class: 'org ', open: true}
        end
        Fdn::User.available.by_org_id(org.id).collect { |x| @node << {id: x.id, pId: "o_#{org.id}", name: x.full_name} }
      end
      @node = @node.to_json
    end

    def show
      user = Fdn::User.find(current_user.id)
      #@message = user.read_message(params[:id])
      @message = Fdn::Message.find(params[:id])
      @tab_idx = params[:tab_idx]
      render layout: 'form'
    end

    def index
      @unread = current_user.inbox_messages.unread params[:unread_page]||1
      @unread_index = current_user.inbox_messages.unread

      @user_msgs = current_user.inbox_messages.user_msg params[:user_page]||1
      @user_msgs_index = current_user.inbox_messages.user_msg

      @process_msgs_index = current_user.inbox_messages.process_msg
      @process_msgs = current_user.inbox_messages.process_msg params[:process_page]||1

      #@listed_comp_msgs = current_user.inbox_messages.listed_comp_msg params[:comp_page]||1
      #@listed_comp_msgs_index = current_user.inbox_messages.listed_comp_msg


      @messages_out = current_user.outbox_messages.where("msg_type != 'Wf::Process'").outbox params[:out_page]||1
      @messages_out_index = current_user.outbox_messages.where("msg_type != 'Wf::Process'").outbox
      @tab_idx = params[:tab_idx] || "0"

      #@search = Fdn::Message.search(params[:q])
      #@messages = current_user.inbox_messages.inbox params[:in_page]||1
      #@messages_index = current_user.inbox_messages.inbox
    end

    def create
      if params[:to_user_ids]
        form_user = Fdn::User.find(params[:form_user_id]||current_user.id)
        subject = params[:subject]||params[:fdn_message][:subject]
        body = params[:body]||params[:fdn_message][:body]
        out_msg = form_user.outbox_messages.build(subject: subject,
                                                  body: body,
                                                  msg_type: "Fdn::User",
                                                  msg_type_id: form_user.id,
                                                  sender_id: form_user.id,
                                                  status: "drafted",
                                                  receivers: params[:to_user_ids])
        if params[:act] == "forward"

        end
        unless !params[:bn_save].blank?
          out_msg.status = "sent"
        end
        if !params[:fdn_message][:file_resources_attributes].blank?
          params[:fdn_message][:file_resources_attributes].each do |file|
            out_msg.file_resources.build(file[1])
          end
        end

        out_msg.save

        #redirect_to fdn_messages_path
        respond_to do |format|
          format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '邮件发送成功！') }
        end

      else
        redirect_to new_fdn_message_path
      end
      #form_user = Fdn::User.find(current_user.id)
      #@file_list = params[:send_file]
      #group_id = Time.now.to_i
      #for user_id in params[:to_user_ids]
      #  unless user_id.blank?
      #    to_user = Fdn::User.find(user_id)
      ##发送站内短信
      #if params[:msg_type] == Fdn::Lookup::MSG_TYPE_MSG
      #  msg_id = form_user.send_message(to_user, params[:fdn_message][:subject], params[:fdn_message][:body], group_id, params[:fdn_message])
      #  #转发附件
      #  unless @file_list.blank?
      #    msg = Fdn::Message.find(msg_id)
      #    @file_list.each do |sms_file|
      #      src_file = Fdn::FileResource.find(sms_file)
      #      msg.forward_file_resources << src_file
      #    end
      #    msg.save
      #  end
      #  sys_noticle = 'message_send_succ'
      #else
      #  #发送手机短信
      #  msg_id = form_user.send_sms(params[:fdn_message][:body])
      #  sys_noticle = 'sms_send_succ'
      #end

      #  end
      #end
      #redirect_to "/workspaces/refresh?message=notice.message.#{sys_noticle}"
    end

    def add_file
      @file = Fdn::FileResource.new
      @message = Fdn::Message.new
      @index = params[:index]
      respond_to do |format|
        format.js
      end
    end

    def del_file
      @file_id = params[:file_id]
      #删除
      unless params[:resource_file_id].nil?
        @file = Fdn::FileResource.find(params[:resource_file_id])
        @file.destroy
      end

      respond_to do |format|
        format.js {
          render :js => "$('#file_tr_#{@file_id}').remove();"
        }
      end
    end

    def read_info
      @message = Fdn::Message.find(params[:id])
      #@messages = Fdn::Message.where(:group_id =>@message.group_id)
      @messages = Fdn::ReceivedMessage.where("message_id=?", params[:id])
      render layout: 'form'
    end

    #删除一组短信
    def destroy_group
      @messages = Fdn::Message.where(:group_id => params[:id])
      @messages.each do |msg|
        msg.trashed_by_receiver = true
        msg.trashed_by_sender = true
        msg.save
      end
      redirect_to(fdn_messages_url(:tab_idx => 1))
    end

    # DELETE /sms_outboxes/1
    # DELETE /sms_outboxes/1.xml
    def destroy
      @message = Fdn::Message.find(params[:id])
      if params[:msg_type] == "receiver"
        @message.trashed_by_receiver = true
      else
        @message.trashed_by_sender = true
      end
      @message.save

      respond_to do |format|
        format.html { redirect_to(fdn_messages_path) }
        format.xml { head :ok }
      end
    end

  end
end
