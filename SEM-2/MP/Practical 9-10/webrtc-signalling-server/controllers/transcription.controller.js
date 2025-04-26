// controllers/transcription.controller.js
const Transcription = require('../models/transcription.model');

// Add a new transcription segment
exports.addTranscription = async (req, res) => {
  try {
    const { callId, speakerId, role, text } = req.body;
    
    if (!callId || !speakerId || !role || !text) {
      return res.status(400).json({ 
        success: false, 
        message: 'Missing required fields' 
      });
    }

    const newTranscription = new Transcription({
      callId,
      speakerId,
      role,
      text
    });

    const savedTranscription = await newTranscription.save();
    
    return res.status(200).json({
      success: true,
      data: savedTranscription
    });
  } catch (error) {
    console.error('Error adding transcription:', error);
    return res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Get transcriptions for a call
exports.getTranscriptions = async (req, res) => {
  try {
    const { callId } = req.params;
    
    if (!callId) {
      return res.status(400).json({
        success: false,
        message: 'Call ID is required'
      });
    }

    // Find all transcriptions for the given callId and sort by timestamp
    const transcriptions = await Transcription.find({ callId })
      .sort({ timestamp: 1 })
      .lean();

    // Group the transcriptions by callId
    const groupedTranscriptions = transcriptions.reduce((acc, curr) => {
      if (!acc[curr.callId]) {
        acc[curr.callId] = [];
      }
      acc[curr.callId].push({
        // _id: curr._id,
        // speakerId: curr.speakerId,
        role: curr.role,
        text: curr.text,
        timestamp: curr.timestamp
      });
      return acc;
    }, {});

    return res.status(200).json({
      data: groupedTranscriptions[callId] || []
    });
  } catch (error) {
    console.error('Error fetching transcriptions:', error);
    return res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};