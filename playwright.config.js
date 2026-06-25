// Minimal Playwright config. The app is a single static file, so tests open it
// directly via file:// (no dev server). The playwright-tester subagent writes its
// spec into ./tests at runtime and resolves index.html with an absolute path.
const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './tests',
  timeout: 15_000,
  expect: { timeout: 5_000 },
  fullyParallel: false,
  reporter: [['list']],
  use: {
    headless: true,
  },
});
