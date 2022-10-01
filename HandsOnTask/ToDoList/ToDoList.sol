// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Todos {
    struct Todo {
        string text; // The text of the todo
        bool completed; // Whether the todo is completed
    }

    // An array of 'Todo' structs
    Todo[] public todos; // public keyword makes variable accessible from outside the contract

    // Create a new todo
    function create(string calldata _text) public { // calldata keyword is used to pass data from outside the contract to a function
        // 3 ways to initialize a struct
        // - calling it like a function
        todos.push(Todo(_text, false)); // push adds an element to the end of an array

        // key value mapping
        todos.push(Todo({text: _text, completed: false}));

        // initialize an empty struct and then update it
        Todo memory todo; // memory keyword is used to define a variable in memory instead of storage
        todo.text = _text; // update todo's text
        // todo.completed initialized to false

        todos.push(todo); // add to array
    }

    // Solidity automatically created a getter for 'todos' so
    // you don't actually need this function.
    function get(uint _index) public view returns (string memory text, bool completed) {
        Todo storage todo = todos[_index]; // storage keyword is used to define a variable in storage instead of memory
        return (todo.text, todo.completed); // return multiple values
    }

    // update text
    function updateText(uint _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text; // update todo's text
    }

    // update completed
    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed; // toggle todo's completed
    }
}
