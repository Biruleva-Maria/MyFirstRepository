const fs = require('fs')
const faker =  require('faker')

let insertValues =  []

let Insert =  `INSERT INTO warehouse (product_id, count)
VALUES`

console.log(Insert)

for (let i = 0; i < 30; i++) 
{
	const product_id = faker.random.number({
        min: 1,
        max: 30,
    })
    const count = faker.random.number({
        min: 0,
        max: 1000,
    })

    const insert =`(${product_id}, ${count}),`
    console.log(insert)
}