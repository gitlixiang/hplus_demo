class Wf::TaskOpinion < ActiveRecord::Base
  belongs_to :task ,:class_name => "Wf::Task" ,:foreign_key => 'task_id'
end
