const functions = require('firebase-functions');
const admin = require('firebase-admin');
const Algolia = require('./algolia/index'); 

admin.initializeApp(functions.config().firebase);

//Algolia
exports.AlgoliaSyncUsers = Algolia.algoliaSyncUsers;
