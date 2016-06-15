#coding: utf-8
module Fdn
  class UserSessionsController < ApplicationController
    layout 'login'
    skip_before_filter :require_user, :only => ['new', 'create', 'js_render_captcha']
    skip_before_filter :authorize

    def new
      @user_session = Fdn::UserSession.new
      @user_session.org_code = cookies[:org_code]
      @tt = Fdn::LegendMenhu.find_by_position('toutiao').legend_category_id
      @tou_tiao = Fdn::Legend.where(type_code: @tt).order("created_at Desc").first
      @top1 = Fdn::LegendMenhu.find_by_position('top1')
      @top2 = Fdn::LegendMenhu.find_by_position('top2')
      @top3 = Fdn::LegendMenhu.find_by_position('top3')
      @top_right = Fdn::LegendMenhu.find_by_position('top_right')

      @middle1 = Fdn::LegendMenhu.find_by_position('middle1')
      @middle2 = Fdn::LegendMenhu.find_by_position('middle2')
      @middle3 = Fdn::LegendMenhu.find_by_position('middle3')

      @gzyw = Fdn::Legend.where(type_code: @top1.legend_category_id).order("created_at Desc").take(5)
      @rdzt = Fdn::Legend.where(type_code: @top2.legend_category_id).order("created_at Desc").take(5)
      @ldzl = Fdn::Legend.where(type_code: @top3.legend_category_id).order("created_at Desc").take(5)
      @tzgg = Fdn::Legend.where(type_code: @top_right.legend_category_id).order("created_at Desc").take(9)

      @gzdt = Fdn::Legend.where(type_code: @middle1.legend_category_id).order("created_at Desc").take(6)
      @qydt = Fdn::Legend.where(type_code: @middle2.legend_category_id).order("created_at Desc").take(6)
      @fgwj = Fdn::Legend.where(type_code: @middle3.legend_category_id).order("created_at Desc").take(6)
    end

    def create
      #logger.info(user_session_params.inspect)
      params[:origin_name] = user_session_params[:username]
      session_params = user_session_params
      session_params[:username] = "#{user_session_params[:org_code]}_#{user_session_params[:username]}"
      @user_session = Fdn::UserSession.new(session_params)
      if simple_captcha_valid?
        if Fdn::Organization.find_by_code(user_session_params[:org_code]).blank?
          @user_session.username = params[:origin_name]
          flash[:notice] = I18n.t('e.base.org_code_err')
          # redirect_to :action => :new
          redirect_to root_url #+'#contact'
        elsif @user_session.save
          #logger.info("login successfully")
          session[:org_id] = current_user.resource_id #if current_user.primary_org
          session[:user_id] = current_user.id

          cookies[:org_code] = {value: user_session_params[:org_code], expires: 10.year.from_now}
                                                      #session[:pos_id] = current_user.primary_pos.id if current_user.primary_pos
                                                      #flash[:notice] = "Login successful!"
          redirect_to '/main/index' #root_url
        else
          @user_session.username = params[:origin_name]
          flash[:notice] = I18n.t('e.base.log_in')
          # redirect_to :action => :new
          redirect_to root_url #+'#contact'
        end
      else
        @user_session.username = params[:origin_name]
        flash[:notice] = I18n.t('simple_captcha.message.user')
        # render :action => :new
        redirect_to root_url #+'#contact'
      end
    end


    def quit
      cookies['fdn/user_credentials'] = nil
      cookies['_session_id'] = nil

      current_user_session.destroy
      flash[:notice] = "退出成功!"
      #respond_to do |format|
      #  format.html
      #end
      redirect_to root_url #new_fdn_user_session_url
    end

    def js_render_captcha

    end

    private
    def user_session_params
      params.require(:fdn_user_session).permit(:org_code, :username, :password, :value)
    end

  end
end