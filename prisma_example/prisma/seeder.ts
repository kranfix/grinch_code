import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
  await prisma.connect()

  const falcon = await prisma.ship.create({
    data: {
      name: 'Millenium Falcon',
      hyperSpaceEnabled: true,
    },
  })

  const delta7 = await prisma.ship.create({
    data: {
      name: 'Delta 7',
      //hyperSpaceEnabled: false,
    },
  })

  await prisma.jedi.create({
    data: {
      name: 'Obiwan Kenobi',
      powerLevel: 87.5,
      race: 'Humano',
      ship: {
        connect: { id: falcon.id },
      },
    },
  })

  await prisma.sidth.create({
    data: {
      name: 'Darth Vader',
      powerLevel: 90.0,
      race: 'Humano',
      ship: {
        connect: { name: delta7.name },
      },
    },
  })
}

main()
  .catch((_) => console.log('Ups, hubo un error!'))
  .then(() => prisma.disconnect())
