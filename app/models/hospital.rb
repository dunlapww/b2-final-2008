class Hospital < ApplicationRecord
  has_many :doctors

  def universities
    doctors.select(:university).distinct
  end
end
