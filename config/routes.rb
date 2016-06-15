Rails.application.routes.draw do
  namespace :hr do
    resources :people do
      member do
        get :change_seat
      end
      collection do
        get :export_index
      end
    end
    resources :person_histories
  end
  namespace :wf do
    resources :simple_workflow do
      collection do
        get :up, :down
      end
    end
    resources :models do
      collection do
        get :index, :new
        post :create
      end
    end
  end
  namespace :pm do
    resources :tasks
    resources :plans do
      member do
        get 'submit', 'return', 'finish', 'close'
      end
      collection do
        get 'add_node', 'del_node'
      end
    end
    resources :nodes
    resources :progresses do
      member do
        get 'list'
        get 'submit', 'return', 'finish', 'close'
      end
    end
    resources :comments do
      member do
        get 'super_create'
      end
    end
    resources :statistics
  end

  namespace :hr do
    resources :training_infos
    resources :training_courses do
      collection do
        get 'course_index'
      end
    end
    #人工成本管理系统
    resources :salaries do
      collection do
        get :detail_refresh
      end
    end
    resources :leader_salaries do
      collection do
        get :detail_refresh
      end
    end
    resources :salary_budgets do
      collection do
        get :detail_refresh
        get :salary_submit, :salary_review, :salary_record
      end
    end
    resources :early_warnings
    #企业人才
    resources :ent_talents do
      collection do
        get 'analysis_index', 'detail_refresh', 'search_index', 'export_list', 'base_index', 'base_new', 'reviewed_index', 'check'
        get 'change_seq'
      end
    end
    #企业车辆
    resources :ent_cars do
      collection do
        get 'detail_refresh'
      end
      member do
        get 'destroy_record'
      end
    end
    #企业负责人
    resources :ent_managers do
      collection do
        get 'detail_refresh', 'show_car'
      end
      member do
        get 'destroy_record'
      end
    end
  end
  namespace :rad do
    #发债还款
    resources :repayments
    #投资
    resources :investments do
      collection do
        get 'add_file', 'del_file', 'rjs_investments_of', 'show_parent', 'event_index', 'wf_index'
        get 'wf_opinion', 'jw_opinion', 'jw_opinions_refresh', 'show_his'
      end
      member do
        patch 'jw_update'
      end
    end
    #发债
    resources :corporate_bonds do
      collection do
        get 'add_file', 'del_file', 'search_index', 'analysis_index', 'show_analysis', 'export_list'
      end
    end
  end
  #财务报表
  namespace :aae do
    resources :financial_statements do
      collection do
        get 'ajax_refresh', 'year_analysis', 'year_index', 'month_analysis', 'short_term_debt_paying', 'long_term_debt_paying',
            'assess_of_economic', 'month_economic_situation', 'month_development_ability', 'month_cash_flow_structure', 'month_detail_refresh',
            'year_detail_refresh', 'financial_warning', 'financial_analysis'
      end
      member do
        get 'destroy_record'
      end
    end
  end
  get 'main/index'

  get 'main/frame_index'

  get 'login/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'login#index'
  root 'fdn/user_sessions#new'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  namespace :fdn do
    #信息分类
    resources :legend_categories do
      collection do
        get 'change_seq', 'stop', 'show_menhu'
      end
      member do
        get 'menhu_edit'
        patch 'menhu_update'
      end
    end
    #基础值集
    resources :lookups
    #发件
    resources :messages do
      collection do
        get 'tree', 'refresh', 'add_file', 'del_file', 'destroy_group', 'read_info'
      end
    end
    #收件
    resources :received_messages do
      collection do
        get 'receive_type'
      end
    end
    #用户管理
    resources :users do
      collection do
        get 'detail_refresh', 'stop', 'add_jq_user', 'del_jq_user'
      end
      member do
        get 'pre_edit'
        patch 'pre_update'
      end
    end
    #功能菜单
    resources :menus do
      collection do
        get 'tree', 'detail_refresh'
      end
    end
    #权限管理
    resources :roles do
      member do
        get 'user', 'right', 'refresh', 'destroy_record'
      end
      collection do
        get 'autocomplete_organization_id', 'treeload', 'kb_tree', 'nb_tree', 'ys_tree', 'org_tree'
        get 'detail_refresh'
      end
    end
    #系统公告
    resources :announcements do
      collection do
        get 'add_file', 'del_file'
      end
    end
    #通知公告
    resources :legends do
      collection do
        get 'add_file', 'add_file_of', 'del_file', 'del_file_of', 'menhu_show', 'menhu_legend_list'
        get 'gov_widget', 'ent_widget', 'district_widget', 'important', 'gov_content'
      end
      member do
        get 'show_page'
      end
    end
    #组织管理
    resources :organizations do
      collection do
        get 'rjs_all_of', 'tree_index', 'ent_index', 'rjs_ent_of', 'rjs_descendants_of', 'rjs_tree_all_of', 'show_tree'
        post 'import_data', 'jq_receive'
        get 'import_ent', 'jq_index', 'visit_jq', 'jq_receive'
        get :layer_select_org, :layer_select_org_js
      end
    end
    get :smart_import_page, 'import_ent'
    post :smart_import, 'import_data'
    #用户sessions
    resources :user_sessions do
      collection do
        get 'js_render_captcha'
      end
      member do
        get 'quit'
      end
    end
    #系统日志
    resources :loggers do
      collection do
        get 'show_info'
      end
    end
    #组织架构
    resources :org_hierarchies

  end

  namespace :oa do
    #发文
    resources :sent_documents do
      collection do
        get 'add_file', 'del_file', 'claim_work'
      end
    end
    #收文
    resources :recv_documents do
      collection do
        get 'add_file', 'del_file'
      end
    end
  end

  namespace :cl do
    resources :contents
    resources :headers do
      member do
        get :set_content
      end
      collection do
        post :get_content
        get :ajax_download
      end
    end
  end

  get '/activiti/service/model/:model_id/json', to: 'wf/models#service_model'
  #mount RailsWorkflow::Engine => '/workflow', as: 'workflow'
  mount ChinaCity::Engine => '/china_city'
  # mount JrubyActiviti::Web => '/activiti' if defined?(JrubyActiviti)


  get '/attachments/:namespace/:class/:attachment/:id/:style.:format' => "attachments#download"

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
