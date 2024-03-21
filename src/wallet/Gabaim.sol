// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;


contract Gabaim{

    address public owner;
     mapping(address => bool) public owners;
     uint public countGabaim=0;

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
    require(owners[key]==false,""); 
   if(countGabaim<3){
      owners[key]=true;
      countGabaim++;
    }
    else{
      revert("There are already 3 Gabaim");
    }
   }

   function changeGabay(address keyold,address newkey) public {
       require(owner==msg.sender,"you not owner");
       require(owners[keyold]==true,"the key not exist");
       require(owners[newkey]==false,"the key already exist");
        owners[keyold]=false;
        owners[newkey]=true;
       
}

}
