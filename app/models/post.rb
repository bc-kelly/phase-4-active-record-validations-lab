class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: ["Fiction", "Non-Fiction"]
    
    validate :clickbait

    CLICKBAIT_PATS = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i,
        /Guess/i
    ]

    def clickbait
        if CLICKBAIT_PATS.none? { |pat| pat.match title}
            errors.add(:title, "must be clickbait")
        end
    end
end

# "Won't Believe"
# "Secret"
# "Top [number]"
# "Guess"
