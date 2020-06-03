const cds = require('@sap/cds')
const express = require('express')
// const supertest = require('supertest')

describe('Stuff Test', () => {
    beforeAll(async () => {
        await cds.deploy(__dirname + '/../srv/cards-srv').to('sqlite::memory:')
        await cds.serve('CardsService').from(__dirname + '/../srv/cards-srv').in(express())
    })

    it('Test stuff out', async () => {
        expect(true).toBeTruthy()
        expect(false).toBeFalsy()
    })

})