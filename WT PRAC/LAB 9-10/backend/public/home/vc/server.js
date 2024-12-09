// server.js
const express = require('express');
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

app.get('/', (req, res) => {
  res.sendFile(__dirname + '/index.html');
});

io.on('connection', (socket) => {
    console.log('A user connected');
  
    socket.on('join', (stream) => {
      socket.broadcast.emit('stream', stream);
    });
  
    socket.on('disconnect', () => {
      console.log('User disconnected');
    });
  });
  
server.listen(3000, () => {
  console.log('Server running on port 3000');
});
