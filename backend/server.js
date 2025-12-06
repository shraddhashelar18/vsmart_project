// server.js
const express = require('express');
const admin = require('firebase-admin');
const cors = require('cors');
const serviceAccount = require('./config/vsmartproject-492e9-firebase-adminsdk-fbsvc-490fe98b6d.json'); // replace with your actual JSON

// 1️⃣ Initialize Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();
const app = express();

// 2️⃣ Middleware
app.use(cors());
app.use(express.json());

// 3️⃣ API: Send low attendance notification
// This works even if FCM token does not exist (for testing)
app.post('/sendLowAttendance', async (req, res) => {
  const { student_id, message, threshold } = req.body;

  // Validate input
  if (!student_id || !message) {
    return res.status(400).json({ error: "student_id and message are required" });
  }

  try {
    // 3a️⃣ Lookup student in Firestore
    const studentDoc = await db.collection('student').doc(student_id).get();

    if (!studentDoc.exists) {
      return res.status(404).json({ error: "Student not found" });
    }

    const studentData = studentDoc.data();
    const fcmToken = studentData.fcmToken;

    // 3b️⃣ Skip FCM if token not available (backend logic test)
    if (!fcmToken) {
      console.log(`No FCM token for student ${student_id}, skipping send`);
      return res.status(200).json({
        success: true,
        warning: "No FCM token, message skipped",
        student: student_id,
        message_sent: message,
        threshold: threshold || "N/A"
      });
    }

    // 3c️⃣ Build notification (will send only if token exists)
    const notification = {
      token: fcmToken,
      notification: {
        title: "Attendance Alert",
        body: message
      },
      data: {
        threshold: threshold ? threshold.toString() : "N/A",
        student_id: student_id
      }
    };

    // 3d️⃣ Send notification
    const response = await admin.messaging().send(notification);

    res.status(200).json({ success: true, id: response });

  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});

// 4️⃣ API: Test list all students
app.get('/students', async (req, res) => {
  try {
    const snapshot = await db.collection('student').get();
    const students = [];
    snapshot.forEach(doc => students.push({ id: doc.id, ...doc.data() }));
    res.status(200).json({ students });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 5️⃣ API: Add student (for testing without frontend)
app.post('/addStudent', async (req, res) => {
  const { student_id, name, fcmToken } = req.body;
  if (!student_id || !name) return res.status(400).json({ error: "student_id and name required" });

  try {
    await db.collection('student').doc(student_id).set({
      name,
      fcmToken: fcmToken || null
    });
    res.status(200).json({ success: true, student: student_id });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 6️⃣ Start server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});