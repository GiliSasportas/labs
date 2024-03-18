// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;


contract Owner{

    address public owner;
     mapping(address => bool) public owners;
     uint count=0;

    constructor(){
        owner=msg.sender;

    }

    receive()external payable {}


    modifier isOrOwnerGabai() {
       require(owners[msg.sender]==true || msg.sender==owner,"not owner or gabai");
        _; 
    }
       
   function withdraw(uint256 num) payable  public isOrOwnerGabai{
     payable(msg.sender).transfer(num);
   }

   function getBalance() public view returns(uint){
    return address(this).balance;
   }

   function addGabay(address key)public {
    require(owner==msg.sender,"you not owner");
    if(count<3){
      owners[key]=true;
      count++;
    }
   }

   function changeGabay(address key,address newkey) public {
       require(owner==msg.sender,"you not owner");
       if(owners[key]==true){
        owners[key]=false;
        owners[newkey]=true;
       }
}
}
