class User < ApplicationRecord
  belongs_to :department

  validates :name, :password, :email_address, :department presence: true
end
