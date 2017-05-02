class Post < ActiveRecord::Base


  validates :title, presence: true
  validates :content, length: { minimum: 30 }
  validates :summary, length: { maximum: 30 }

  validates :category, inclusion: { in: %w(Fiction Non-fiction), message: "%{value} is not a valid category"}

  validate :title, :must_be_clickbait

  # validate :category_is_a_choice, :must_be_clickbait
  #
  #
  # def category_is_a_choice
  #   choice = ["Fiction", "Non-fiction"]
  #   choice.include?(:category): errors.add()
  # end
  #
  def must_be_clickbait
    clickbait = ["Won't Believe", "Secret", "Top [0-9]", "Guess"]

    if title.present?
      clickbait_status = false
      clickbait.each do |bait|
        clickbait_status = true if title.include?(bait)
      end

      errors.add(:title, "must include clickbait ") if !clickbait_status
    end
  end

end
