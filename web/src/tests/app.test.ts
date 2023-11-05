import request from 'supertest'
import app from '../app'

describe('Default Endpoint', () => {
    it('should return status 200', async () => {
        const res = await request(app)
            .get('/')
        expect(res.statusCode).toEqual(200)
    })
})

