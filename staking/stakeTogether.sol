// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.6;

contract StakeTogether {

    uint256 public rewards;
    mapping(address => uint256) public owners;

    constructor() {
        rewards=msg.sender();
    }

    receive() external public;
   
}