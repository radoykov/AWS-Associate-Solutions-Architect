import { Amplify } from 'aws-amplify';
import { generateClient } from 'aws-amplify/api';
import config from './aws-exports.js';

Amplify.configure(config);

const client = generateClient();

const listMyAppSyncTablesQuery = `
query listMyAppSyncTables {
  listMyAppSyncTables {
    items {
      pk
      fruit
      level
    }
  }
}
`;

async function fetchData() {
  try {
    const response = await client.graphql({ 
      query: listMyAppSyncTablesQuery 
    });
    
    console.log('--- AWS AppSync Connection Successful ---');
    console.log('Data:', JSON.stringify(response.data, null, 2));
  } catch (error) {
    console.error('Error fetching from AppSync:', error);
  }
}

fetchData();
