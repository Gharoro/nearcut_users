class User < ApplicationRecord
  PASSWORD_REQUIREMENTS = /\A
  (?=.{10,16}\z)
  (?=.*\d)
  (?=.*[a-z])
  (?=.*[A-Z])
  (?:([\w\d*?!:;])\1?(?!\1))+
/x
  validates :name, :password, presence: true
  validates :password, format: PASSWORD_REQUIREMENTS
end
