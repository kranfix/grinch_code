import { nexusPrismaPlugin } from 'nexus-prisma'
import {
  intArg,
  makeSchema,
  objectType,
  stringArg,
  booleanArg,
  arg,
} from 'nexus'

const JediGql = objectType({
  name: 'Jedi',
  rootTyping: {
    name: 'Jedi',
    path: '@prisma/client',
  },
  definition(t) {
    t.boolean('isMaster', {
      async resolve() {
        return true
      },
    })

    t.string('name', {
      args: {
        uppercase: booleanArg({ nullable: true, default: false }),
      },
      resolve(root, args) {
        if (args.uppercase) {
          return (root.name as String).toUpperCase()
        }
        return root.name
      },
    })

    t.float('powerLevel', {
      resolve(root) {
        return root.powerLevel
      },
    })
  },
})

const SidthGql = objectType({
  name: 'Sidth',
  rootTyping: {
    name: 'Sidth',
    path: '@prisma/client',
  },
  definition(t) {
    t.string('name', {
      args: {
        uppercase: booleanArg({ nullable: true, default: false }),
      },
      resolve(root, args) {
        if (args.uppercase) {
          return (root.name as String).toUpperCase()
        }
        return root.name
      },
    })

    t.float('powerLevel', {
      resolve(root) {
        return root.powerLevel
      },
    })
  },
})

const queryGql = objectType({
  name: 'Query',
  definition(t) {
    t.field('jedi', {
      type: 'Jedi',
      args: {
        id: intArg({ required: true, description: 'id del Jedi' }),
      },
      async resolve(_, args, ctx) {
        return ctx.prisma.jedi.findOne({
          where: {
            id: args.id,
          },
        })
      },
    })

    t.field('sidth', {
      type: 'Sidth',
      args: {
        id: intArg({ required: true, description: 'id del Jedi' }),
      },
      async resolve(_, args, ctx) {
        return ctx.prisma.sidth.findOne({
          where: {
            id: args.id,
          },
        })
      },
    })
  },
})

export const schema = makeSchema({
  types: [queryGql, JediGql, SidthGql],
  plugins: [nexusPrismaPlugin()],
  outputs: {
    schema: __dirname + '/../schema.graphql',
    typegen: __dirname + '/generated/nexus.ts',
  },
  typegenAutoConfig: {
    contextType: 'Context.Context',
    sources: [
      {
        source: '@prisma/client',
        alias: 'prisma',
      },
      {
        source: require.resolve('./context'),
        alias: 'Context',
      },
    ],
  },
})
