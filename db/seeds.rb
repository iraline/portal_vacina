# frozen_string_literal: true

ELEMENTS = 4

(0..ELEMENTS).map do |element|
  state = "State #{element}"
  state = State.create(name: state)

  city = "City #{element}"
  city = City.create(name: city)

  locality = Locality.create(state_id: state.id, city_id: city.id)

  unity = Unity.create(name: "Unity #{element}")

  vaccine = Vaccine.create(name: "Vaccine #{element}")

  Role.create(name: "Roles #{element}")

  person = Person.create(name: "Person #{element}",
                         born_at: '05/05/2000',
                         locality_id: locality.id,
                         cpf: "0000000000#{element}")

  Shot.create(person_id: person.id,
              locality_id: locality.id,
              vaccine_id: vaccine.id,
              unity_id: unity.id)
end
