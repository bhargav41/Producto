const database = require('../database');
test('Testing DB Connection', async () => {
    return database().then((val) => {
        expect(database() !== null).toBe(true)
        return;
    }).catch((err) => {
        console.log(err);
        expect(1 === 0).toBe(true);
        return;
    })
});
