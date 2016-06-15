FactoryGirl.define do
  factory :pm_comment, :class => 'Pm::Comment' do
    content "MyText"
    comment_time "2015-09-11 14:43:15"
    user_id 1
    resource nil
  end

end
