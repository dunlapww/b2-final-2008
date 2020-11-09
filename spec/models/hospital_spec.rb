require 'rails_helper'

describe Hospital, type: :model do
  describe 'relationships' do
    it {should have_many :doctors}
  end

  describe 'instance_methods' do
    it '#universities' do
      @hospital = Hospital.create!({name: "Centura Health"})
      @hospital2 = Hospital.create!({name: "Porters"})
      @hospital3 = Hospital.create!({name: "St. Joes"})
      @dr_jeff = @hospital.doctors.create!({name: "Jeff", specialty: "Pulmonary", university: "Duke"})
      @dr_sara = @hospital.doctors.create!({name: "Sara", specialty: "Cardiology", university: "Stanford"})
      @dr_sally = @hospital.doctors.create!({name: "Sally", specialty: "Anesthesiology", university: "Stanford"})
      @dr_jake = @hospital2.doctors.create!({name: "Jake", specialty: "Epidemiology", university: "Harvard"})
      
      #patients
      @p_steve = @dr_jeff.patients.create!({name: "Steve", age: 45})
      PatientDoctor.create!({patient_id: @p_steve.id, doctor_id: @dr_sara.id})
      
      @p_greg = @dr_jeff.patients.create!({name: "Greg", age: 30})
      @p_nick = @dr_jeff.patients.create!({name: "Nick", age: 25})

      @p_will = @dr_sara.patients.create!({name: "Will", age: 41})
      @p_jen = @dr_sara.patients.create!({name: "Jen", age: 50})

      expect(@hospital.universities).to eq(["Duke", "Stanford"])
      expect(@hospital2.universities).to eq(["Harvard"])
      expect(@hospital3.universities).to eq([])
    end
  end
end
