pragma solidity ^0.8.7;

// SPDX-License-Identifier: MIT

contract FeeCollector {
    // store the address of the owner of the contract
    address public owner; // store the address of the owner of the contract
    uint256 public balance; // store the balance of the contract

    // constructor() is called when the contract is deployed
    constructor() {
        owner = msg.sender; // store information who deployed contract
    }

    // fallback function is called when the contract receives funds
    receive() external payable {
        balance += msg.value; // keep track of balance (in WEI)
    }

    //function getBalance() public view returns (uint256) {
    function withdraw(uint amount, address payable destAddr) public {
        require(msg.sender == owner, "Only owner can withdraw"); // only owner can withdraw
        require(amount <= balance, "Insufficient funds"); // only withdraw if enough funds

        destAddr.transfer(amount); // send funds to given address
        balance -= amount; // update balance
    }
}
