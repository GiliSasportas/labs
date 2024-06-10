// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

constant immutable{
    address public  immutable MY_ADDRESS;
    uint public immutable MY_UINT;

    constructor(uint _myUint){
        MY_ADDRESS=msg.sender;
        MY_UINT=_myUint;
    }
}