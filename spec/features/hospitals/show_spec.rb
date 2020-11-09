require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a hospital's show page" do
    before :each do
      @hospital = Hospital.create!({name: "Centura Health"})
      @hospital2 = Hospital.create!({name: "Porters"})
      @dr_jeff = @hospital.doctors.create!({name: "Jeff", specialty: "Pulmonary", university: "Duke"})
      @dr_sara = @hospital.doctors.create!({name: "Sara", specialty: "Cardiology", university: "Stanford"})
      @dr_sally = @hospital.doctors.create!({name: "Sally", specialty: "Anesthesiology", university: "Stanford"})
      @dr_jake = @hospital2.doctors.create!({name: "Jake", specialty: "Epidemiology", university: "Stanford"})
      
      #patients
      @p_steve = @dr_jeff.patients.create!({name: "Steve", age: 45})
      PatientDoctor.create!({patient_id: @p_steve.id, doctor_id: @dr_sara.id})
      
      @p_greg = @dr_jeff.patients.create!({name: "Greg", age: 30})
      @p_nick = @dr_jeff.patients.create!({name: "Nick", age: 25})

      @p_will = @dr_sara.patients.create!({name: "Will", age: 41})
      @p_jen = @dr_sara.patients.create!({name: "Jen", age: 50})

    end
    it "displays the hospital name" do
      visit "hospitals/#{@hospital.id}"
      
      expect(page).to have_content(@hospital.name)
    end
    
    it "I see the number of doctors that work there" do
      visit "hospitals/#{@hospital.id}"
      expect(page).to have_content("Num of Doctors: 3")
    end
    
    it "I see the names of doctors that work at the hospital" do
      visit "hospitals/#{@hospital.id}"
      
      within "#doctor-#{@dr_jeff.id}"  do
        expect(page).to have_content(@dr_jeff.name)
      end
      
      within "#doctor-#{@dr_sara.id}"  do
        expect(page).to have_content(@dr_sara.name)
      end
      
      expect(page).to_not have_content(@dr_jake.name)
    end
    
    it "I see a unique list of universities that the doctors attended" do
      visit "hospitals/#{@hospital.id}"

      expect(page).to have_content("Universities Represented: Duke, Stanford")
    end
  end
end
