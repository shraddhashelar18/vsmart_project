import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const serviceAccount = require("../config/vsmartproject-492e9-00a41a88b53e.json");

// Initialize Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

// 🔥 1) Test Notification (CHECK THIS FIRST)
export const sendTestNotification = functions.https.onRequest(async (req, res) => {
  try {
    const response = await admin.messaging().send({
      notification: {
        title: "Test Notification",
        body: "Firebase Cloud Messaging is working!",
      },
      topic: "testTopic",
    });

    res.status(200).send({ success: true, id: response });
  } catch (error: any) {
    res.status(500).send({ success: false, error: error.message });
  }
});

// 🔥 2) Send to specific FCM Token
export const sendToDevice = functions.https.onRequest(async (req, res) => {
  try {
    const token = req.body.token;
    const title = req.body.title;
    const body = req.body.body;

    const message = {
      notification: { title, body },
      token: token,
    };

    await admin.messaging().send(message);
    res.status(200).send("Notification sent successfully to device!");
  } catch (error: any) {
    res.status(500).send(error.message);
  }
});