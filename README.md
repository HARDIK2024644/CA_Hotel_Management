# Hotel Booking 🏨

Hi! This is my blockchain assignment. I built a simple hotel booking app where a **smart contract** looks after the money instead of a booking website.

**By:**Hardik Singh Pawar (Student No. 2024644)

## Why I made this

When you book a hotel online, a website sits in the middle. It takes a fee, it can mess up bookings, and you have to trust it with your money. I wanted to see if a smart contract could do that job with simple rules that anyone can check.

## How it works

1. The **hotel** adds a room and sets the price per night.
2. A **guest** books the room and pays into the contract.
3. Those nights are now locked, so **nobody else can book them**.
4. The contract holds the money while the guest is away.
5. After the stay, the hotel checks the guest out and **gets paid**.
6. If the guest cancels before arriving, they get **90% back**.

So the guest is the **sender**, the hotel is the **receiver**, and the blockchain is the **trusted middle**.

## Keeping it safe

- I only store a **hash** of the guest's details on the blockchain. It's a short code, so no personal info is public.
- Every payment is **signed** with the guest's private key, so only the real guest can pay or cancel.

## What's in this folder

| File | What it does |
|---|---|
| `HotelBooking.sol` | The smart contract, written in Solidity |
| `deploy_and_test.py` | A Python script that deploys the contract and tests it |
| `run.sh` | A shell script that sets everything up and runs the tests |

## What I used

Solidity, Remix IDE, Ganache, Python (web3.py) and a shell script.

## How to run it

You'll need **Node.js**, **Python 3** and **Git**. On Windows, use Git Bash.

```bash
git clone https://github.com/HARDIK2024644/CA_Hotel_Management.git
cd hotel-booking
chmod +x run.sh
./run.sh
```

It starts a practice blockchain, runs the tests, and finishes with **"All checks passed"**.

### Want to try it by hand in Remix?

1. Start Ganache: `npx ganache --port 8545 --wallet.deterministic`
2. Go to [remix.ethereum.org](https://remix.ethereum.org) and paste in `HotelBooking.sol`
3. Compile it with version **0.8.19**
4. In the Deploy tab, choose **Ganache** and click **Deploy**
5. Try `addRoom`, then `bookRoom`, then `checkIn` and `checkOut`

## What I tested

- Only the hotel can add rooms.
- A guest can book and pay.
- Booking the same nights twice gets **blocked**.
- Paying the wrong amount gets **blocked**.
- Only the hotel can take the money out.
- Cancelling gives a 90% refund.

## What I'd improve

- Dates are plain numbers (like day 100) instead of real dates.
- There's no website screen yet, just Remix and Python.
- It's a learning project, so please don't use it with real money.

## Link

GitHub: https://github.com/HARDIK2024644/CA_Hotel_Management.git