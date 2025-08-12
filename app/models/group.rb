class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy #追加
    has_many :users, through: :group_users, dependent: :destroy #追加
    has_many :chat_messages, dependent: :destroy
    # validates :name, presence: true, uniqueness: true
end
