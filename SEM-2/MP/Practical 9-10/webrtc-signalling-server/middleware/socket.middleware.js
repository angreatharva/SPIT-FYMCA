// Socket.io middleware for authentication
const socketAuth = (socket, next) => {
  if (socket.handshake.query) {
    let callerId = socket.handshake.query.callerId;
    socket.user = callerId;
    next();
  } else {
    next(new Error('Authentication error'));
  }
};

module.exports = socketAuth; 