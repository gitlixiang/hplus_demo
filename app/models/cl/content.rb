class Cl::Content < ActiveRecord::Base
  belongs_to :cl_header, :class_name => 'Cl::Header', foreign_key: :header_id
end
