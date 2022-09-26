// Constants
// Constants are variables that cannot be modified.
//* Their value is hard coded and using constants can save gas cost.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Constants {
    // coding convention to uppercase constant variables
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint public constant MY_UINT = 123;
}

// Immutable
// Immutable variables are like constants. Values of immutable variables can be set inside the constructor but cannot be modified afterwards.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Immutable {
    // coding convention to uppercase constant variables
    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;

    constructor(uint _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}

// Detailed information.
// https://docs.soliditylang.org/en/v0.8.15/contracts.html#constant-and-immutable-state-variables