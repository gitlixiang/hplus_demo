FactoryGirl.define do
  factory :cl_header, :class => 'Cl::Header' do
    name "MyString"
    resource_type "MyString"
    code "MyString"
    order 1
  end

end
