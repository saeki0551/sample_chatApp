class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy #追加
    has_many :users, through: :group_users, dependent: :destroy #追加
    # validates :name, presence: true, uniqueness: true
end
