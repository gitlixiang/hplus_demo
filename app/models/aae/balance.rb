class Aae::Balance < ActiveRecord::Base

  belongs_to :financial_statement, :class_name => 'Aae::FinancialStatement'

end
