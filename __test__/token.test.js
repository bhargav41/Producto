const token = require('../shared/token');
test('Test Token', () => {
    expect(token.generateToken({message: 'This is a test'}).length > 0).toBe(true);
});
