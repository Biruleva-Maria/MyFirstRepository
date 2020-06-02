const fs = require('fs')
const faker =  require('faker')

let insertValues =  []

let Insert =  `INSERT INTO product (name)
VALUES`

console.log(Insert)

for (let i = 0; i < 30; i++) 
{
    const name = faker.random.word()

    const insert =`('${name}'),`
    console.log(insert)
}