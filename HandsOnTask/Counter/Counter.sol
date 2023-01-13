// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Counter {
    // State variable to store the count
    uint256 public count;

    // Function to get the current count
    // This function is a "view" function, meaning it does not change the state of the contract
    function get() public view returns (uint256) {
        return count;
    }

    // Function to increment count by 1
    // This function is a "pure" function, meaning it does not change the state of the contract
    function inc() public {
        // This function will fail if count = 2^256 - 1
        count += 1;
    }

    // Function to decrement count by 1
    function dec() public {
        // This function will fail if count = 0
        count -= 1;
    }
}
