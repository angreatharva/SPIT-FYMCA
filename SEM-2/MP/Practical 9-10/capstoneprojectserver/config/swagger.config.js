const swaggerJsdoc = require('swagger-jsdoc');

// Swagger definition
const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Capstone Project API',
      version: '1.0.0',
      description: 'API documentation for the Capstone Project - Healthcare Platform',
      contact: {
        name: 'API Support',
        email: 'support@healthcare-platform.com'
      },
      license: {
        name: 'ISC',
        url: 'https://opensource.org/licenses/ISC'
      }
    },
    servers: [
      {
        url: 'http://localhost:5000',
        description: 'Development server',
      },
      {
        url: 'https://healthcare-platform-api.example.com',
        description: 'Production server',
      }
    ],
    tags: [
      {
        name: 'Authentication',
        description: 'User authentication and registration endpoints'
      },
      {
        name: 'Users',
        description: 'User management endpoints'
      },
      {
        name: 'Doctors',
        description: 'Doctor-related endpoints'
      },
      {
        name: 'Health',
        description: 'Health tracking and wellness endpoints'
      },
      {
        name: 'Health Admin',
        description: 'Administrative endpoints for health data'
      },
      {
        name: 'Video Call',
        description: 'Video calling and telehealth endpoints'
      },
      {
        name: 'Blogs',
        description: 'Health blog and article endpoints'
      },
      {
        name: 'Transcriptions',
        description: 'Call transcription endpoints'
      }
    ],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
        }
      },
      schemas: {
        Error: {
          type: 'object',
          properties: {
            success: {
              type: 'boolean',
              example: false
            },
            message: {
              type: 'string',
              example: 'Error message'
            }
          }
        }
      }
    },
    security: [{
      bearerAuth: []
    }]
  },
  // Path to API docs
  apis: [
    './routes/*.js',
    './models/*.js'
  ],
};

const specs = swaggerJsdoc(options);

module.exports = specs; 