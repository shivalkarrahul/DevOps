const app = require('../server'),
request = require('supertest');



describe('API Test',()=>{
     afterEach(function (done) {
        app.close(done)
     });

    it('Should return string in the GET Call',(done)=>{
        request(app).get('/').expect('Content-Type',/text/).expect(200).end((error)=>{
            if(error) throw done(error);
            done();
        });
    });
});
