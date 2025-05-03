const socketAuth = require('../middleware/socket.middleware');

const setupSocketServer = (io) => {
  // Apply socket authentication middleware
  io.use(socketAuth);

  io.on("connection", (socket) => {
    console.log(`User ${socket.user} connected to socket server`);
    socket.join(socket.user);

    // Handle callerId verification
    socket.on("verifyCallerId", (data) => {
      const verifiedCallerId = data.callerId;
      
      // Check if the callerId matches what's in the socket
      if (socket.user !== verifiedCallerId) {
        console.log(`Updating caller ID from ${socket.user} to ${verifiedCallerId}`);
        
        // Have the socket leave the old room
        socket.leave(socket.user);
        
        // Update the socket.user value
        socket.user = verifiedCallerId;
        
        // Join the new room
        socket.join(verifiedCallerId);
        
        // Acknowledge the change
        socket.emit("callerIdVerified", { success: true, callerId: verifiedCallerId });
      } else {
        console.log(`Caller ID verified: ${verifiedCallerId}`);
        socket.emit("callerIdVerified", { success: true, callerId: verifiedCallerId });
      }
    });

    socket.on("makeCall", (data) => {
      let calleeId = data.calleeId;
      let sdpOffer = data.sdpOffer;
      
      console.log(`User ${socket.user} is calling ${calleeId}`);

      socket.to(calleeId).emit("newCall", {
        callerId: socket.user,
        sdpOffer: sdpOffer,
      });
    });

    socket.on("answerCall", (data) => {
      let callerId = data.callerId;
      let sdpAnswer = data.sdpAnswer;
      
      console.log(`User ${socket.user} is answering call from ${callerId}`);

      socket.to(callerId).emit("callAnswered", {
        callee: socket.user,
        sdpAnswer: sdpAnswer,
      });
    });

    socket.on("IceCandidate", (data) => {
      let calleeId = data.calleeId;
      let iceCandidate = data.iceCandidate;

      socket.to(calleeId).emit("IceCandidate", {
        sender: socket.user,
        iceCandidate: iceCandidate,
      });
    });
    
    // Handle call request acceptance
    socket.on("callRequestAccepted", (data) => {
      console.log(`Call request accepted by ${socket.user} for patient ${data.patientCallerId}`);
      const patientCallerId = data.patientCallerId;
      
      // Notify the patient that their call request was accepted
      socket.to(patientCallerId).emit("callRequestAccepted", {
        requestId: data.requestId,
        doctorCallerId: data.doctorCallerId,
        doctorName: data.doctorName,
      });
    });
    
    // Handle transcription events
    socket.on("transcription", (data) => {
      // Broadcast to the room for real-time updates
      socket.to(data.callId).emit("transcriptionUpdate", data);
    });
    
    // Handle disconnection
    socket.on("disconnect", () => {
      console.log(`User ${socket.user} disconnected from socket server`);
    });
  });
};

module.exports = setupSocketServer; 