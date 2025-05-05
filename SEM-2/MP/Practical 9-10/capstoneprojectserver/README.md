# WebRTC Signalling Server

## Clone Repository

Clone the repository to your local environment.

```sh
git clone https://github.com/videosdk-live/webrtc.git
```

### Server Setup

#### Step 1: Go to  webrtc-signalling-server folder

```js
cd webrtc-signalling-server
```

#### Step 2: Install Dependency

```js
npm install
```

#### Step 3: Run the project

```js
npm run server
```

## API Documentation

The API endpoints are documented using Swagger UI. Once the server is running, you can access the API documentation at:

```
http://localhost:5000/api-docs
```

This provides an interactive interface to explore and test all available endpoints.

## Testing

The application includes automated tests using Jest and Supertest.

To run the tests:

```js
npm test
```

To generate a test coverage report:

```js
npm run test:coverage
```

For more details about the API documentation and testing, see [API_DOCS.md](./API_DOCS.md).

---
