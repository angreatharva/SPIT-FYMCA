const multer = require('multer');

// Setup multer for handling image uploads
const storage = multer.memoryStorage();

const upload = multer({
  storage: storage,
  limits: { fileSize: 20 * 1024 * 1024 }, // Limit to 20MB
}).single('image');

module.exports = upload; 