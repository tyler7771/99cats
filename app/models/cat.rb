class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: %w(Red White Black Brown Orange Grey)}
  validates :sex, inclusion: { in: %w(M F)}
  has_many :cat_rental_requests, dependent: :destroy

  def age
    age = Date.today - self.birth_date
    if age > 365
      years = age.to_i / 365
      return "Over #{years} years!"
    else
      days = age.to_i % 365
      return "#{days} days!"
    end
  end

  def self.color
    %w(Red White Black Brown Orange Grey)
  end

  def self.sex
    %w(M F)
  end
end
