class ChainExit < ActiveRecord::Base
  belongs_to :chain_exit, :class_name => 'Chain' 
end
