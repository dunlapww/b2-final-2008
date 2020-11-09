# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PatientDoctor.destroy_all
Patient.destroy_all
Doctor.destroy_all
Hospital.destroy_all

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
