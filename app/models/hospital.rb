class Hospital < ApplicationRecord
  has_many :doctors

  def universities
    doctors.select(:university).distinct.pluck(:university)
  end
end
