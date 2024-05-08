// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Divide{

    address[] public addresses;

    function addUser(address ad) public{
      addresses.push(ad);

    }

    function divideToAddresess() external payable{
        require(addresses.length > 0,"There are no users");
        uint256 amountDivide = msg.value / addresses.length;
        for(uint i=0; i<addresses.length ;i++){
          payable(addresses[i]).transfer(amountDivide);
        }
    }

}
