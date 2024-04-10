import { Pact, createClient } from '@kadena/client';

// Initialize Pact client
const client = createClient('https://api.testnet.chainweb.com/chainweb/0.0/testnet04/chain/1/pact');

// Function to fetch data from Pact
async function fetchData() {
const unsignedTransaction = Pact.builder
    .execution(`(free.vote-testing.read-with-votes "vote1")`)
    .setMeta({
        chainId: '1',
        gasLimit: 5000,
    })
    .setNetworkId('testnet04')
    .createTransaction();

    try {
        const result = await client.dirtyRead(unsignedTransaction)
        console.log("results", result.result.data)
        return result.result?.data;
    } catch (error) {
        console.error('Error with dirtyRead', error)
        throw error;
    }
}
fetchData()
