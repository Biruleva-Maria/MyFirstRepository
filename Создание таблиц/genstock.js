const fs = require('fs')
const faker =  require('faker')

let insertValues =  []

let Insert =  `INSERT INTO stock (product_id, cotegory, discription)
VALUES`

console.log(Insert)

for (let i = 0; i < 30; i++) 
{
	const product_id =  faker.random.number({
        min: 1,
        max: 30,
    })
    
	const cotegory = faker.random.words()
	const description = faker.random.words()
	
    const insert =`(${product_id}, '${cotegory}', '${description}'),`
    console.log(insert)
}