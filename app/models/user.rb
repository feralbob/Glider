class User < ActiveRecord::Base
  has_many :messages, :dependent => :delete_all
  validates_uniqueness_of :username, :message => "already has been taken, try again."
  validates_presence_of   :username, :message => "must be provided!"
end
