class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED)}
  belongs_to :cat
  validate :overlapping_requests

  def overlapping_requests
    @cat = Cat.find_by_id(self.cat_id)
    rentals = @cat.cat_rental_requests
    rentals = rentals.select {|request| request.status == "APPROVED" }
    if overlapping_approved_requests(rentals) == true
      errors[:status] << "cat already rented"
    end
  end

  def overlapping_approved_requests(existing_rentals)
    existing_rentals.each do |rental|
      if (self.end_date < rental.start_date && self.start_date < rental.start_date) && self.id != rental.id
        return false
      elsif (self.end_date > rental.end_date && self.start_date > rental.end_date) && self.id != rental.id
        return false

      # elsif rental.start_date >= self.start_date && rental.start_date <= self.end_date && self.id != rental.id
      #   return true
      # elsif rental.end_date >= self.start_date && rental.end_date <= self.end_date && self.id != rental.id
      #   return true
      else
        return true
      end
    end
  end
end
