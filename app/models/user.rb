class User < ActiveRecord::Base
    
has_many :authorizations
validates :name, :email,  :presence => true
validates :email, :uniqueness => {:message => 'must be unique per contact'}
serialize :contacts
end
