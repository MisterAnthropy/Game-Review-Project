class Genre < ApplicationRecord
    has_many :games
    validates :genre_name, uniqueness: true, presence: true

    def self.alpha
        order(:genre_name)
    end

end
