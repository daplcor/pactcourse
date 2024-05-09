import { useState } from 'react'
import './App.css'
import { pactCalls } from './components/kadena.js';

function App() {
  const [account, setAccount] = useState('');
  const [chain, setChain] = useState('0');
  const [balance, setBalance] = useState(null);
  const [guard, setGuard] = useState(null);


const getAccountDetails = async () => {
  try {
    const code = `(coin.details "${account}")`;
    const details = await pactCalls(code, chain);
    if (details.balance < 1000.0)
    {
      return alert("Insufficient funds");
    }
    setBalance(details.balance);
    setGuard(JSON.stringify(details.guard, null, 2));
  } catch (error) {
    console.error('Error fetching account details: ', error);
  }
};

const getBalance = async () => {
  try {
    const code = `(coin.get-balance "${account}")`;
    const balance = await pactCalls(code, chain);
    setBalance(balance);
    setGuard(null);
  } catch (error) {
    console.error('Error fetching account balance: ', error);
  }

};

  return (
    <div className="app">
    <h1>Pact Course</h1>
    <div className="card">
      <div className="cardbundle">
        <input
        type="text"
        placeholder="Account Name"
        value={account}
        onChange={(e) => setAccount(e.target.value)}
        />
        <select value={chain} onChange={(e) => setChain(e.target.value)}>
            {[...Array(20)].map((_, i) => (
              <option key={i} value={i}>
                Chain {i}
              </option>
            ))}
          </select>
      </div>
      <div className="button-container">
        <button onClick={getAccountDetails}>Get Account Details</button>
        <button onClick={getBalance}>Get Balance</button>
        </div>
        {balance !== null && (
          <p>
            Balance: <span className="highlight">{balance}</span>
          </p>
        )}
        {guard !== null && (
          <div className="guard-container">
          <pre>
            Guard: <span className="highlight">{guard}</span>
          </pre>
          </div>
        )}
      </div>
    </div>
  )
}

export default App
