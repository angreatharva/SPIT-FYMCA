const socketAuth = require('../middleware/socket.middleware');

const setupSocketServer = (io) => {
  // Apply socket authentication middleware
  io.use(socketAuth);

  io.on("connection", (socket) => {
    console.log(socket.user, "Connected");
    socket.join(socket.user);

    socket.on("makeCall", (data) => {
      let calleeId = data.calleeId;
      let sdpOffer = data.sdpOffer;

      socket.to(calleeId).emit("newCall", {
        callerId: socket.user,
        sdpOffer: sdpOffer,
      });
    });

    socket.on("answerCall", (data) => {
      let callerId = data.callerId;
      let sdpAnswer = data.sdpAnswer;

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
      console.log("Call request accepted:", data);
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
  });
};

module.exports = setupSocketServer; 