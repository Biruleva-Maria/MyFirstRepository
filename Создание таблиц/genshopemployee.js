const fs = require('fs')
const faker =  require('faker')

let insertValues =  []

let Insert =  `INSERT INTO shop_employee (shop_id, employee_id, date_start, date_finish, working_day, weekend)
VALUES`

console.log(Insert)

for (let i = 0; i < 30; i++) 
{
	const shop_id =  faker.random.number({
        min: 1,
        max: 30,
    })
	const employee_id = faker.random.number({
        min: 1,
        max: 30,
    })
    
	const date_start = faker.date.past(10).toDateString()

	let date_finish =  null
    if (faker.random.number( 10)  >  5 ) 
    {
        date_finish =  faker.date.past(10).toDateString()
        date_finish = `'${date_finish}'`
    }
    const k=faker.random.number(7)
	const working_day = k
    const weekend = 7-k

    const insert =`(${shop_id}, ${employee_id}, '${date_start}', ${date_finish}, '${working_day}', '${weekend}'),`
    console.log(insert)
}