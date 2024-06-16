// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract Struct{
    Struct Todo{
        string text,
        bool b
    }
    Todo[] public todos;
    function create(string calldata s)public{
        todos.push(Todos(s,false));
        todos.push(Todo({text:s,b:false}));
        todos memory t;
        t.text=s;
        todos.push(t);
    }
    function get(uint index)public view returns(string calldata string,bool b){
        Todo storage t = todos[index];
        return (t.text, t.b);
    }
    function updateText(uint index,string calldata str) public{
        Todo storage s= todos[index];
        s.text=str;
    }
    function updateBool(uint index)public{
        Todo storage s= todos[index];
        s.b=false;
    }
}
