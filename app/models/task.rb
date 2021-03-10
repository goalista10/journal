class Task < ApplicationRecord
    validates :name, presence: true, uniqueness: { scope: :category_id }
    belongs_to :category
end
