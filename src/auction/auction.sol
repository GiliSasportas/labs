// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract auction{

    bool started=false;
    address public owner;
    uint256 public sum;
    uint256 public amountDays;
    

    constructor{
        owner = msg.sender;

    }



}