# API Documentation & Testing

## Swagger UI Documentation

The API is documented using Swagger UI, which provides an interactive interface to explore and test the APIs.

### Accessing Swagger UI

Once the server is running, you can access the Swagger UI documentation at:

```
http://localhost:5000/api-docs
```

### Features of Swagger UI

- Interactive API documentation
- Test API endpoints directly from the browser
- Detailed request and response schemas
- Authentication support with JWT token

## Documented API Endpoints

The following API endpoints are documented and can be tested via Swagger UI:

### Authentication

- `POST /api/auth/login` - User or doctor login
- `POST /api/auth/logout` - Logout the user or doctor
- `POST /api/auth/register/user` - Register a new user
- `POST /api/auth/register/doctor` - Register a new doctor
- `GET /api/auth/users` - Get all registered users
- `GET /api/auth/user/{id}` - Get user details by ID

### Doctors

- `GET /api/doctors/available` - Get all available doctors
- `GET /api/doctors/{id}/status` - Get doctor's status
- `GET /api/doctors/{id}` - Get doctor details by ID
- `PATCH /api/doctors/{id}/toggle-status` - Toggle doctor's availability status

### Health Tracking

- `GET /api/health/questions` - Get all health questions
- `GET /api/health/questions/role/{role}` - Get questions by role (patient, doctor, both)
- `GET /api/health/tracking/{userId}` - Get today's health tracking for a user
- `POST /api/health/tracking/{userId}/{trackingId}/complete/{questionId}` - Complete a health question
- `GET /api/health/heatmap/{userId}` - Get health activity heatmap data for a user
- `POST /api/health/admin/refresh` - Manually trigger a refresh of all health tracking records
- `POST /api/health/admin/backfill` - Backfill health activity data

### Video Calls

- `GET /api/video-call/active-doctors` - Get all active doctors (for patients)
- `POST /api/video-call/request-call` - Request a video call (for patients)
- `GET /api/video-call/pending-requests/{doctorId}` - Get pending call requests (for doctors)
- `PATCH /api/video-call/request/{requestId}` - Update call request status (for doctors)

### Blogs

- `POST /api/blogs` - Create a new blog post
- `POST /api/blogs/upload-image` - Upload a blog image
- `GET /api/blogs` - Get all blogs with pagination
- `GET /api/blogs/user/{userId}` - Get blogs by user (patient or doctor)
- `GET /api/blogs/{id}` - Get a single blog by ID
- `PUT /api/blogs/{id}` - Update a blog
- `DELETE /api/blogs/{id}` - Delete a blog

### Transcriptions

- `POST /api/transcriptions` - Add a new transcription
- `GET /api/transcriptions/{callId}` - Get all transcriptions for a call

## Authentication

Most API endpoints require authentication using JWT tokens.

To authenticate with the API:

1. Login using `/api/auth/login` endpoint to get a token
2. Add the token to the Authorization header in subsequent requests:
   ```
   Authorization: Bearer YOUR_TOKEN
   ```

## API Testing with Jest

The application uses Jest and Supertest for API testing.

### Running Tests

To run the tests, use the following command:

```bash
npm test
```

### Test Coverage

To generate a test coverage report, run:

```bash
npm run test:coverage
```

### Test Structure

The tests are organized in the following structure:

```
├── tests/
│   ├── setup.js              # Test environment setup
│   ├── auth.test.js          # Authentication API tests
│   └── ... (other test files)
```

### Writing Tests

When writing tests for new API endpoints, follow these guidelines:

1. Create a new test file in the `tests` directory
2. Import necessary modules:
   ```javascript
   const request = require('supertest');
   const app = require('../index');
   ```
3. Use descriptive test names
4. Clean up test data after tests
5. Test both success and error cases 