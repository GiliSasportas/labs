// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SimpleStorage {
    uint public num;
    function set(uint _num) public{
        num=_num;
    }

    function get() public view returns(uint256){
        ret num;
    }
}