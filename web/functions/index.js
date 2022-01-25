const functions = require('firebase-functions');
const admin = require('firebase-admin');
const scheduler = require('./scheduler/scheduler');

admin.initializeApp(functions.config().firebase);

//Schedulers
exports.addCoinsToAllUsers = scheduler.addCoinsToAllUsers;
