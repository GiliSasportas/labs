// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract counter{
    uint public counter;

    function get() view returns(uint) {
        return count;

    }

    function inc() public{
         count+1;
    }

    function dec() public {
        count -= 1;
    }
}