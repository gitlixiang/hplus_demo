#coding: utf-8
class AttachmentsController < ApplicationController
  SEND_METHOD = :default

  def download
    head(:not_found) and return if (obj = eval(params[:namespace].classify + "::" + params[:class].classify).find params[:id]).nil?
    attachment = obj.send(params[:attachment].singularize.to_sym)
    path = attachment.path

    #logger.info(path)

    head(:bad_request) and return unless File.exist?(path) && File.extname(path) == '.'+params[:format].to_s
    file_name = obj.attributes['true_file_name'].nil? ? attachment.original_filename : obj.attributes['true_file_name']
    file_name = file_name.encode('GBK')

    send_file_options = {:type => attachment.content_type, :filename => file_name}

    case SEND_METHOD
      when :apache then
        send_file_options[:x_sendfile] = true
      when :nginx then
        head(:x_accel_redirect => path.gsub(Rails.root, ''), :content_type => send_file_options[:type]) and return
    end

    send_file(path, send_file_options)
  end

end
