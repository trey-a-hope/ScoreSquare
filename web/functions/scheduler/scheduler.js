const functions = require('firebase-functions');
const admin = require('firebase-admin');

//“At 00:00 on day-of-month 1.”
exports.addCoinsToAllUsers = functions.pubsub.schedule('21 23 * * *').timeZone('America/New_York').onRun(async (context) => {
    //https://crontab.guru/

    //Query of all users in database.
    const usersSnapshot = await admin.firestore().collection('users').get();

    //Coins that will be added to each user.
    const coins = 10;

    //Iterate over each user in the database.
    await Promise.all(usersSnapshot.docs.map(
        (userDoc) => {
            //Extract data from user document.
            const data = userDoc.data();

            //Add coins to this user.
            if (data['uid'] === 'LZHPLuXGJzNxXnv97xgcJUApuIz2') {
                userDoc.ref.update({ 'coins': admin.firestore.FieldValue.increment(coins) });

                // //Send notification to user.
                // if (data['fcmToken'] !== null) {
                //     //Create payload.
                //     const payload = {
                //         token: data['fcmToken'],
                //         notification: {
                //             title: 'HAPPY FRIDAY!',
                //             body: `You just received ${coins} free coins!`,
                //         },
                //         data: {
                //             body: message,
                //         }
                //     };

                //     //Send message.
                //     admin.messaging().send(payload);
                // }
            }
        }
    ))
});