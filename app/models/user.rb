class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart, dependent: :destroy
  has_many :orders

  def create_cart
    Cart.create!(
      user_id: self.id
    )
  end

  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end


end
