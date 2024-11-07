# TokenFarm Project

## Overview

The **TokenFarm** project consists of three smart contracts: **RobToken**, **CatToken**, and **TokenFarm**. 

- **RobToken** is an ERC-20 token that users can stake into the **TokenFarm** contract.
- **CatToken** is another ERC-20 token that is used as a reward for users who stake their **RobToken**.
- **TokenFarm** allows users to stake their **RobToken**, and in return, they receive rewards in **CatToken**.

## Components

### 1. **RobToken** (ERC-20 Token)

This contract implements a standard ERC-20 token called **RobToken** (symbol: **ROB**). It allows for the creation, transfer, and approval of tokens between users.

- **Total Supply:** 1,000,000 tokens (with 18 decimal places).
- **Events:** `Transfer` and `Approval` events.
- **Functions:**
  - `transfer(address _to, uint256 _value)`: Transfer tokens from the sender to another address.
  - `approve(address _spender, uint256 _value)`: Approve a spender to transfer a specific amount of tokens on behalf of the sender.
  - `transferFrom(address _from, address _to, uint256 _value)`: Allow a spender to transfer tokens on behalf of a user, within the approved allowance.

### 2. **CatToken** (ERC-20 Token)

This contract implements another ERC-20 token called **CatToken** (symbol: **CAT**), which is used as a reward for users staking **RobToken**.

- **Total Supply:** 1,000,000 tokens (with 18 decimal places).
- **Events:** `Transfer` and `Approval` events.
- **Functions:**
  - Same as **RobToken**, including the ability to transfer tokens, approve spenders, and allow others to transfer tokens on behalf of the owner.

### 3. **TokenFarm** (Staking Contract)

This contract allows users to stake **RobToken** and receive **CatToken** as rewards.

- **Owner:** The contract owner is the only entity that can issue rewards.
- **Stake Tokens:** Users can stake **RobToken** by transferring them to the **TokenFarm** contract.
- **Unstake Tokens:** Users can withdraw their staked tokens.
- **Issue Rewards:** The contract owner can distribute **CatToken** rewards to all stakers based on the amount they have staked.
  
#### Functions:
- `stakeToken(uint _amount)`: Users can stake **RobToken** into the contract. The contract checks that the amount is greater than zero, and updates the user's staking balance.
- `unstakeToken()`: Users can withdraw their staked **RobToken** from the contract, resetting their staking balance.
- `issueToken()`: Only the contract owner can distribute **CatToken** rewards to all users who have staked **RobToken**.

### How to Interact with the Contracts

To interact with these contracts, you can use tools like **Remix IDE**, **Truffle**, or **Hardhat** for deployment and testing. 

1. **Deploy the Contracts:**
   - Deploy the **RobToken** and **CatToken** contracts first. Make sure to deploy **RobToken** before **CatToken** as the **TokenFarm** contract depends on them.
   - Deploy the **TokenFarm** contract, passing the addresses of the deployed **RobToken** and **CatToken** contracts as constructor parameters.

2. **Staking RobToken:**
   - Call the `stakeToken(uint _amount)` function of the **TokenFarm** contract, passing the amount of **RobToken** to stake.
   - You will need to approve the **TokenFarm** contract to spend **RobToken** before staking using `approve(address _spender, uint256 _value)` in the **RobToken** contract.

3. **Unstaking RobToken:**
   - Call the `unstakeToken()` function to withdraw your staked **RobToken** from the **TokenFarm** contract.

4. **Issuing Rewards:**
   - The contract owner can call the `issueToken()` function to distribute **CatToken** rewards to all stakers.

## Requirements

- Solidity version `^0.8.7`
- A Solidity-compatible IDE or framework like **Remix IDE**, **Truffle**, or **Hardhat**.

## License

This project is licensed under the MIT License.

