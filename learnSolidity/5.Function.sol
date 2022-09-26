// There are several ways to return outputs from a function.
//* Public functions cannot accept certain data types as inputs or outputs

// public: It can be called by anyone.
// private: It can only be called by the contract itself.
// internal: It can only be called by the contract itself or by contracts deriving from it.
// external: It can only be called by other contracts and accounts.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Function {
    function add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }

    function sub(uint x, uint y) external pure returns (uint) {
        return x - y;
    }

    // Functions can return multiple values.
    function returnMany()
        public
        pure
        returns (
            uint,
            bool,
            uint
        )
    {
        return (1, true, 2);
    }

    // Return values can be named.
    function named()
        public
        pure
        returns (
            uint x,
            bool b,
            uint y
        )
    {
        return (1, true, 2);
    }

    // Return values can be assigned to their name.
    // In this case the return statement can be omitted.
    function assigned()
        public
        pure
        returns (
            uint x,
            bool b,
            uint y
        )
    {
        x = 1;
        b = true;
        y = 2;
    }

    // Use destructuring assignment when calling another
    // function that returns multiple values.
    function destructuringAssignments()
        public
        pure
        returns (
            uint,
            bool,
            uint,
            uint,
            uint
        )
    {
        (uint i, bool b, uint j) = returnMany();

        // Values can be left out.
        (uint x, , uint y) = (4, 5, 6);

        return (i, b, j, x, y);
    }

    // Cannot use map for either input or output

    // Can use array for input
    function arrayInput(uint[] memory _arr) public {}

    // Can use array for output
    uint[] public arr;

    function arrayOutput() public view returns (uint[] memory) {
        return arr;
    }

    uint public num;

    // View: Indicates that the function will read data from the blockchain but not modify it.
    function viewFunction() public view returns (uint) {
        return num;
    }

    // Pure: It states that the function will neither read nor modify data from the blockchain.
    function pureFunction() public pure returns (uint) {
        return 1;
    }

    // View and pure functions are not allowed to modify state variables.
    // View and pure functions can return values but cannot modify state variables.

    // View functions can read state variables.
    function addToNum(uint x) external view returns (uint) {
        return num + x;
    }

    // Pure functions cannot read state variables.
    function add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }
}

// Detailed information.
// https://docs.soliditylang.org/en/v0.8.15/types.html#function-types
// https://github.com/itublockchain/web3-bootcamp/tree/master/1x1_Functions
