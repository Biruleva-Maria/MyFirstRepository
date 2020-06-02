const fs = require('fs')
const faker =  require('faker')

let insertValues =  []

let Insert =  `INSERT INTO division (name, description, date_start)
VALUES`

console.log(Insert)

for (let i = 0; i < 30; i++) 
{
	const name = faker.company.companyName()
	const description = faker.random.words()
	const date_start = faker.date.past(10).toDateString()

    const insert =`('${name}', '${description}', '${date_start}'),`
    console.log(insert)
}