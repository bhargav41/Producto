const config = require("../config");
test("Test Config", () => {
  expect(
    config.apiKey.length > 0 &&
      config.domain.length > 0 &&
      config.expiresIn.length > 0 &&
      config.logs.level.length > 0 &&
      config.saltRounds > 0 &&
      config.secret.length > 0 &&
      config.uri.length > 0
  ).toBe(true);
});
