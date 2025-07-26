class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :likes, dependent: :destroy
  has_many :chat_room_users
  has_many :chat_rooms, through: :chat_room_users 
  has_many :chat_messages

    has_many :group_users, dependent: :destroy #追加
    has_many :groups, through: :group_users, dependent: :destroy #追加

end
