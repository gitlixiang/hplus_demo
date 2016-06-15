class Fdn::ReceivedMessage < ActiveRecord::Base
  validates_presence_of :receiver

  belongs_to :message
  belongs_to :receiver, :polymorphic => true

  delegate :subject, :to => :message
  delegate :body, :to => :message
  delegate :sender, :to => :message
  delegate :receivers, :to => :message
  delegate :group, :to => :message
  delegate :msg_type_value, :to => :message

  scope :order_by_created_at, -> { order("fdn_received_messages.created_at desc") }
  scope :inbox_untrashed, -> { where("fdn_received_messages.trashed_by_receiver = 0") }
  scope :inbox_trashed, -> { where("fdn_received_messages.trashed_by_receiver = 1") }
  scope :inbox_unread, -> { where("fdn_received_messages.read = 0") }
  scope :inbox_read, -> { where("fdn_received_messages.read = 1") }
  scope :user_mgs, -> { joins(:message).where("fdn_messages.msg_type = 'Fdn::User'") }
  scope :process_mgs, -> { joins(:message).where("fdn_messages.msg_type = 'Wf::Process'") }
  scope :listed_comp_mgs, -> { joins(:message).where("fdn_messages.msg_type = 'Prs::ListedCompany'") }
  scope :user_rec_message, proc { |ids, user_id| where("message_id in (?) and receiver_type = 'Fdn::User' and receiver_id=?", ids, user_id) }

  def be_read(user)
    if user == self.receiver && self.read == 0
      self.read = 1
      self.read_at = Time.now
      self.save
    end
    self
  end

  def be_trashed(user)
    if user == self.receiver && self.trashed_by_receiver == 0
      self.trashed_by_receiver = 1
      self.save
    end
    self
  end
end
