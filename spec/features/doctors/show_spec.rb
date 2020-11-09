require 'rails_helper'

describe 'As a visitor' do
  describe 'when i visit a doctors show page' do
    before :each do
      @hospital = Hospital.create!({name: "Centura Health"})
      @dr_jeff = @hospital.doctors.create!({name: "Jeff", specialty: "Pulmonary", university: "Duke"})
      @dr_sara = @hospital.doctors.create!({name: "Sara", specialty: "Cardiology", university: "Stanford"})
      
      #patients
      @p_steve = @dr_jeff.patients.create!({name: "Steve", age: 45})
      PatientDoctor.create!({patient_id: @p_steve.id, doctor_id: @dr_sara.id})
      
      @p_greg = @dr_jeff.patients.create!({name: "Greg", age: 30})
      @p_nick = @dr_jeff.patients.create!({name: "Nick", age: 25})

      @p_will = @dr_sara.patients.create!({name: "Will", age: 41})
      @p_jen = @dr_sara.patients.create!({name: "Jen", age: 50})

    end
    
    it "I see all the doctor's details (name, specialty, university)" do
      visit "/doctors/#{@dr_jeff.id}"
      within("#doctor-details") do
        expect(page).to have_content(@dr_jeff.name)
        expect(page).to have_content(@dr_jeff.specialty)
        expect(page).to have_content(@dr_jeff.university)
        expect(page).to have_content(@dr_jeff.hospital.name)
      end
    end

    it "I see the names of all the patients this doctor sees" do
      visit "/doctors/#{@dr_jeff.id}"
      within "#patient-#{@p_steve.id}" do
        expect(page).to have_content(@p_steve.name)
      end
      
      within("#patient-#{@p_greg.id}") do
        expect(page).to have_content(@p_greg.name)
      end
      
      within("#patient-#{@p_nick.id}") do
        expect(page).to have_content(@p_nick.name)
      end
      
      expect(page).to_not have_content(@p_will.name)
    end
    
    it "next to each patient I see a button to remove the patient" do
      visit "/doctors/#{@dr_jeff.id}"
      
      within "#patient-#{@p_steve.id}" do
        expect(page).to have_button("Remove Patient")
      end
      
      within("#patient-#{@p_greg.id}") do
        expect(page).to have_button("Remove Patient")
      end
      
      within("#patient-#{@p_nick.id}") do
        expect(page).to have_button("Remove Patient")
      end
    end
    
    it "when I click a 'remove patient' button, the patient is removed from the doctor and I'm redirected to the doctor show page" do
      
      visit "/doctors/#{@dr_jeff.id}"
      
      within "#patient-#{@p_steve.id}" do
        click_on("Remove Patient")
      end
      
      expect(current_path).to eq("/doctors/#{@dr_jeff.id}")
      expect(page).to_not have_content(@p_steve.id)

    end

  end
end
