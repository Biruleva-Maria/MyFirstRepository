const fs = require('fs')
const faker =  require('faker')

let insertValues =  []

let Insert =  `INSERT INTO employee (name, surname, middle_name, phone, email, date_birthday)
VALUES`

console.log(Insert)

for (let i = 0; i < 30; i++) 
{
	const name = faker.name.firstName()
	const surname = faker.name.lastName()
	const middle_name = faker.name.firstName()
	const email = faker.internet.email()
	const phone = faker.phone.phoneNumber()
    const date_birthday = faker.date.past(10).toDateString()

    const insert =`('${name}', '${surname}', '${middle_name}', '${phone}', '${email}', '${date_birthday}'),`
    console.log(insert)
}