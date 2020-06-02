const fs = require('fs')
const faker =  require('faker')

let insertValues =  []

let Insert =  `INSERT INTO shop (name, city, street, house, date_start, date_finish)
VALUES`

console.log(Insert)

for (let i = 0; i < 30; i++) 
{
	const name = faker.company.companyName()
	const city = faker.address.city()
	const street = faker.address.streetName()
	const house = faker.random.number(200)
	const phone = faker.phone.phoneNumber()
    const date_start = faker.date.past(10).toDateString()

	let date_finish =  null
    if (faker.random.number( 10)  >  5 ) 
    {
        date_finish =  faker.date.past(10).toDateString()
        date_finish = `'${date_finish}'`
	}

    const insert =`('${name}', '${city}', '${street}', ${house}, '${date_start}', ${date_finish}),`
    console.log(insert)
}