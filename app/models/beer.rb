class Beer < ApplicationRecord
    validates :name, :brewery, presence: true, length: { minimum: 2}
    validates :name, uniqueness: { scope:  :brewery }
end
