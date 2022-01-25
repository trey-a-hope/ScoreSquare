const functions = require('firebase-functions');
const admin = require('firebase-admin');

//“At 5pm every Friday”
exports.addCoinsToAllUsers = functions.pubsub.schedule('00 17 * * 5').timeZone('America/New_York').onRun(async (context) => {
    //https://crontab.guru/

    //Query of all users in database.
    const usersSnapshot = await admin.firestore().collection('users').get();

    //Coins that will be added to each user.
    const coins = 50;

    //Iterate over each user in the database.
    await Promise.all(usersSnapshot.docs.map(
        (userDoc) => {
            //Extract data from user document.
            const data = userDoc.data();

            //Add coins to user.
            userDoc.ref.update({ 'coins': admin.firestore.FieldValue.increment(coins) });

            //Send notification to user.
            if (data['fcmToken'] !== null) {
                //Create payload. 
                var message = {
                    notification: {
                        title: 'HAPPY FRIDAY!',
                        body: `You just received ${coins} free coins!`,
                    },
                };

                //Send message.
                admin.messaging().sendToDevice(data['fcmToken'], message);
            }
        }
    ))
});