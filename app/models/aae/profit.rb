class Aae::Profit < ActiveRecord::Base
  belongs_to :financial_statement, :class_name => 'Aae::FinancialStatement'
end
