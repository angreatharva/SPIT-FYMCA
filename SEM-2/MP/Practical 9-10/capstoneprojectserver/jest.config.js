module.exports = {
  testEnvironment: 'node',
  verbose: true,
  testTimeout: 30000,
  coveragePathIgnorePatterns: [
    '/node_modules/'
  ],
  testMatch: [
    '**/tests/**/*.test.js'
  ],
  setupFiles: ['./tests/setup.js']
}; 