// Socket.io middleware for authentication
const socketAuth = (socket, next) => {
  if (socket.handshake.query) {
    let callerId = socket.handshake.query.callerId;
    console.log(`Socket connection attempt with caller ID: ${callerId}`);
    socket.user = callerId;
    next();
  } else {
    console.log('Socket connection rejected: Missing caller ID');
    next(new Error('Authentication error'));
  }
};

module.exports = socketAuth; 