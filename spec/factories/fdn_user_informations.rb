#coding: utf-8
FactoryGirl.define do
  factory :user_info, :class => 'Fdn::UserInformation' do
    full_name '初审'
  end

  factory :ent_user_info, :class => 'Fdn::UserInformation' do
    full_name '办理人'
  end

  factory :ghost_admin_info, :class => 'Fdn::UserInformation' do
    full_name '隐藏管理员'
  end

  factory :adv_user_info, :class => 'Fdn::UserInformation' do
    full_name '复审'
  end

  factory :ent_adv_user_info, :class => 'Fdn::UserInformation' do
    full_name '审核'
  end

  factory :admin_user_info, :class => 'Fdn::UserInformation' do
    full_name '管理员'
  end

  factory :jw_user_info, :class => 'Fdn::UserInformation' do
    full_name '纪委'
  end

  factory :cwys_user_info, :class => 'Fdn::UserInformation' do
    full_name '财务'
  end

  factory :leader_info, :class => 'Fdn::UserInformation' do
    full_name '领导'
  end

  factory :pt_user_info, :class => 'Fdn::UserInformation' do
    full_name '纳税'
  end

  factory :fin_user_info, :class => 'Fdn::UserInformation' do
    full_name '财务'
  end

end
