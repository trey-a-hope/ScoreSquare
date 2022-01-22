const functions = require('firebase-functions');
const algoliasearch = require('algoliasearch');
const algoliaSync = require('algolia-firestore-sync');

const env = functions.config();
const client = algoliasearch(env.algolia.application_id, env.algolia.admin_api_key);
const index = client.initIndex('users');


exports.algoliaSyncUsers = functions.firestore
    .document('users/{id}')
    .onWrite((change, context) => {
        return algoliaSync.syncAlgoliaWithFirestore(index, change, context);
    });

