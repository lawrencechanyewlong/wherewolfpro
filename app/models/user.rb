class User < ActiveRecord::Base
    
has_many :authorizations
validates :name, :email, :presence => true
serialize :contacts
end
