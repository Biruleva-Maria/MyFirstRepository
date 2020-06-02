const fs = require('fs')
const faker =  require('faker')

let insertValues =  []

let Insert =  `INSERT INTO buy (shop_id, product_id, client_id, amount_spent)
VALUES`

console.log(Insert)

for (let i = 0; i < 30; i++) 
{
	const shop_id =  faker.random.number({
        min: 1,
        max: 30,
    })
	const product_id = faker.random.number({
        min: 1,
        max: 30,
    })
	const client_id = faker.random.number({
        min: 1,
        max: 30,
    })
    const amount_spent = faker.random.number({
        min: 0,
        max: 100000,
    })

    const insert =`(${shop_id}, ${product_id}, ${client_id}, '${amount_spent}'),`
    console.log(insert)
}