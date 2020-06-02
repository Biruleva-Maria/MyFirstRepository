const fs = require('fs')
const faker =  require('faker')

let insertValues =  []

let Insert =  `INSERT INTO property (product_id, cotegory, descriptoin)
VALUES`

console.log(Insert)

for (let i = 0; i < 30; i++) 
{
	const product_id =  faker.random.number({
        min: 1,
        max: 30,
    })
    
	const cotegory = faker.random.words()
	const descriptoin = faker.random.words()

    const insert =`(${product_id}, '${cotegory}', '${descriptoin}'),`
    console.log(insert)
}