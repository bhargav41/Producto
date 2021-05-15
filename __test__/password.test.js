const password = require('../shared/password');
test('test password verify', () => {
    expect(password.verifyPassword('TESTPASS', '$2a$10$c4J3JufJFME2BIcy9IIqB.oN4.U5SdsmhquWtL42L0zZHD2A9x0NO')).toBe(true)
});
