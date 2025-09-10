
# Memory Collection Castle 🏰

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Built with Solidity](https://img.shields.io/badge/built%20with-Solidity-blue.svg)](https://soliditylang.org/)

A decentralized application built on the Ethereum blockchain where users can store, share, and treasure their memories in a digital castle. Each memory is an immutable record, and each room is a unique, user-owned space to house these moments.

## Table of Contents

- [Concept](#concept)
- [Core Features](#core-features)
- [Smart Contract Architecture](#smart-contract-architecture)
  - [Data Structures](#data-structures)
  - [Key Functions](#key-functions)
- [Getting Started with Remix IDE](#getting-started-with-remix-ide)
  - [Prerequisites](#prerequisites)
  - [Deployment Steps](#deployment-steps)
- [Example Workflow](#example-workflow)
- [Technical Notes](#technical-notes)
- [Future Enhancements](#future-enhancements)
- [License](#license)

## Concept

The Memory Collection Castle is a metaphorical space where blockchain technology is used to give permanence and ownership to our most valuable memories. Users can create "Rooms" which act as themed galleries. Within these rooms, they can store "Memories," which can be personal reflections, achievements, or moments shared with others.

The contract includes social features like friendships and liking memories, as well as a unique "Time Capsule" feature, which keeps memories locked until a future date, creating a sense of anticipation and digital legacy.

## Core Features

-   **Create Memories**: Store memories immutably on the blockchain, including a title, description, and a link to an image via its IPFS hash.
-   **Build Rooms**: Mint your own unique rooms with custom names and themes to categorize and house your memories.
-   **Access Control**: Rooms and memories can be set to public or private. Private rooms are only accessible to the owner and specifically allowed visitors.
-   **Time Capsules**: Lock a memory until a specified future date. The contents remain hidden until the unlock time, even on the blockchain.
-   **Social Interactions**:
    -   **Friendships**: Form on-chain friendships to grant access to certain private rooms or memories.
    -   **Like Memories**: Show appreciation for public or shared memories.
-   **On-Chain Ownership**: Every user has true ownership of their rooms and the memories they create.

## Smart Contract Architecture

The entire logic is contained within the `MemoryCollectionCastle.sol` smart contract.

### Data Structures

-   `Memory`: A struct that holds all information related to a single memory, including its creator, content, IPFS hash, privacy settings, and time capsule status.
-   `Room`: A struct representing a room in the castle, containing its owner, theme, privacy status, and a list of memories.
-   `MemoryType`: An enum to categorize memories (e.g., `Personal`, `Travel`, `Achievement`).

### Key Functions

-   `storeMemory(...)`: The primary function to create and save a new memory.
-   `createRoom(...)`: Allows a user to create a new room.
-   `shareAndLikeMemory(...)`: A multi-purpose function to "like" a memory and optionally form a friendship with another user.
-   `getMemory(...)`: A view function to retrieve the details of a memory, which respects the privacy and time capsule rules.
-   `allowRoomVisitor(...)`: A function for room owners to grant access to their private rooms.

## Getting Started with Remix IDE

You can easily deploy and test this contract using the [Remix IDE](https://remix.ethereum.org/), a browser-based development environment.

### Prerequisites

-   A web browser with the [MetaMask](https://metamask.io/) extension installed.
-   Some test Ether for a test network (e.g., Sepolia). You can get this from a public faucet like [sepoliafaucet.com](https://sepoliafaucet.com/).

### Deployment Steps

1.  **Open Remix**: Navigate to [remix.ethereum.org](https://remix.ethereum.org).
2.  **New File**: Create a new file named `MemoryCollectionCastle.sol` and paste the contract code into it.
3.  **Compile**:
    -   Go to the "Solidity Compiler" tab.
    -   Select a compiler version compatible with the pragma (e.g., `0.8.19`).
    -   Click **"Compile MemoryCollectionCastle.sol"**. Look for a green checkmark indicating success.
4.  **Deploy**:
    -   Go to the "Deploy & Run Transactions" tab.
    -   For the **ENVIRONMENT**, select **"Injected Provider - MetaMask"**. Your MetaMask will pop up asking for a connection; approve it.
    -   Ensure your MetaMask is connected to a test network (e.g., Sepolia).
    -   Click the orange **"Deploy"** button.
    -   MetaMask will pop up again to confirm the transaction. Click **"Confirm"** to pay the gas fee and deploy the contract.
5.  **Interact**: Once deployed, the contract will appear at the bottom of the Remix panel, where you can expand it to interact with all its functions.

## Example Workflow

1.  Alice calls `createRoom` with the name "My Travels" and sets `_isPublic` to `true`.
2.  She receives a `roomId` of `0`.
3.  Alice then calls `storeMemory` with details of her trip, an IPFS image hash, and sets the `_roomId` to `0`.
4.  Her friend Bob finds the memory. He calls `shareAndLikeMemory`, passing in the `memoryId` to "like" it.
5.  Alice can later view the `likes` count on her memory, which has now increased.

## Technical Notes

-   **IPFS for Media**: To keep gas costs low and store rich media, the `imageHash` field is designed to hold the Content Identifier (CID) of a file stored on the InterPlanetary File System (IPFS). The actual image data is not stored on-chain.
-   **Gas Efficiency**: Functions and data structures are designed to be as gas-efficient as possible, but storing data on Ethereum is inherently costly. Each memory and room creation will incur a gas fee.

## Future Enhancements

-   **Edit Functionality**: Add the ability for creators to edit the details of their memories or rooms.
-   **ENS Integration**: Allow users to use their ENS (Ethereum Name Service) names instead of wallet addresses.
-   **Front-End Interface**: Build a web application to provide a beautiful and user-friendly interface for interacting with the smart contract.
-   **ERC-721/1155 NFTs**: Represent Rooms or special Memories as NFTs, making them tradable and further cementing ownership.


##  Contract Address:0xb8D468a5413e878bE442b17e09898A90fd50FF27
<img width="1797" height="798" alt="image" src="https://github.com/user-attachments/assets/45e5a3e9-624a-42e7-9d53-708c86f1f637" />





## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
