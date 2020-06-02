const fs = require('fs')
const faker =  require('faker')

let insertValues =  []

let Insert =  `INSERT INTO supplier (name, phone, email)
VALUES`

console.log(Insert)

for (let i = 0; i < 30; i++) 
{
	const name = faker.company.companyName()
	const email = faker.internet.email()
	const phone = faker.phone.phoneNumber()

    const insert =`('${name}', '${phone}', '${email}'),`
    console.log(insert)
}