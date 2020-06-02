const fs = require('fs')
const faker =  require('faker')

let insertValues =  []

let Insert =  `INSERT INTO client (name, surname, middle_name, phone, email, number_card)
VALUES`

console.log(Insert)

for (let i = 0; i < 30; i++) 
{
	const name = faker.name.firstName()
	const surname = faker.name.lastName()
	const middle_name = faker.name.firstName()
	const email = faker.internet.email()
    const phone = faker.phone.phoneNumber()
    
    const number_card = faker.random.number({
        min: 0000000000,
        max: 9999999999,
    })

    const insert =`('${name}', '${surname}', '${middle_name}', '${phone}', '${email}', '${number_card}'),`
    console.log(insert)
}