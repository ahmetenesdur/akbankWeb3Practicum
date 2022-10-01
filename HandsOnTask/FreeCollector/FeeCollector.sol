pragma solidity ^0.8.7;

// SPDX-License-Identifier: MIT

contract FeeCollector {
    address public owner; // owner of the contract
    uint256 public balance; // variable that we hold the balance of the contract, we can access balance of the contract by address(this).balance

    // constructor is a function that is called when the contract is deployed
    constructor() {
        owner = msg.sender; // owner of the contract is the address that deploys it
    }

    // function to deposit ether to the contract
    receive() external payable {
        balance += msg.value; // keep track of balance (in WEI)
    }

    // function to withdraw ether from the contract
    function withdraw(uint amount, address payable destAddr) public {
        require(msg.sender == owner, "Only owner can withdraw"); // check if the msg.sender is the current owner of the contract
        require(amount <= balance, "Insufficient funds"); // check if the amount to withdraw is less than the balance of the contract

        destAddr.transfer(amount); // send funds to given address
        balance -= amount; // update balance
    }
}
