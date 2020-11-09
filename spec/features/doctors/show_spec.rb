require 'rails_helper'

describe 'As a visitor' do
  describe 'when i visit a doctors show page' do
    before :each do
      @hospital = Hospital.create!({name: "Centura Health"})
      @dr_jeff = @hospital.doctors.create!({name: "Jeff", specialty: "Pulmonary", university: "Duke"})
      @dr_sara = @hospital.doctors.create!({name: "Sara", specialty: "Cardiology", university: "Stanford"})
      
      #patients
      @p_steve = @dr_jeff.patients.create!({name: "Steve", age: 45})
      @p_steve = PatientDoctor.create!({patient_id: @p_steve.id, doctor_id: @dr_sara.id})
      
      @p_greg = @dr_jeff.patients.create!({name: "Greg", age: 30})
      @p_nick = @dr_jeff.patients.create!({name: "Nick", age: 25})

      @p_will = @dr_sara.patients.create!({name: "Will", age: 41})
      @p_jen = @dr_sara.patients.create!({name: "Jen", age: 50})

    end
    it "I see all the doctor's details" do
      
    end
    it "I see the name of the hospital where the doctor works"
    it "I see the names of all the patients this doctor sees"
  end
end
