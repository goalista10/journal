class Task < ApplicationRecord
    validates :name, presence: true, uniqueness: { scope: :category_id ,:case_sensitive => false }
    belongs_to :category
end
