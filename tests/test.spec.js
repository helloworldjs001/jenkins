// @ts-check
const { test, expect } = require("@playwright/test");
test("Test", async ({
page,
}) => {
await page.goto("https://example.com/");
await expect(page).toHaveTitle(/Example/);
});
