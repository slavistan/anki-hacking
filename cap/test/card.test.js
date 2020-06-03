const cds = require('@sap/cds')

describe('Stuff Test', () => {
    const app = require('express')()
    const request = require('supertest')(app)

    beforeAll(async () => {
        await cds.deploy(__dirname + '/../srv/cards-srv').to('sqlite::memory:')
        await cds.serve('CardsService').from(__dirname + '/../srv/cards-srv').in(app)
    })

    it('Test stuff out', async () => {
        expect(true).toBeTruthy()
        expect(false).toBeTruthy()
    })
})