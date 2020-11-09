class Hospital < ApplicationRecord
  has_many :doctors

  def universities
    doctors.select(:university).distinct.pluck(:university)
  end

  def num_of_doctors
    doctors.count
  end
end
