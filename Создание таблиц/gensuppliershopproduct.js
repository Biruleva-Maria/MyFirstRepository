const fs = require('fs')
const faker =  require('faker')

let insertValues =  []

let Insert =  `INSERT INTO supplier_shop_product (shop_id, employee_id, supplier_id, price, count)
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
	const supplier_id = faker.random.number({
        min: 1,
        max: 30,
    })
	const price = faker.random.number({
        min: 0,
        max: 1000,
    })
    const count = faker.random.number({
        min: 0,
        max: 10,
    })

    const insert =`(${shop_id}, ${employee_id}, ${supplier_id}, ${price}, ${count}),`
    console.log(insert)
}