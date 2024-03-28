// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Gabaim{

     address public owner;
     mapping(address => bool) public owners;
     uint public countowners=0;

    constructor(){
        owner=msg.sender;
    }

    receive()external payable {}


    modifier isOrOwnerGabay() {
       require(owners[msg.sender]==true || msg.sender==owner,"not owner or Gabay");
        _; 
    }
       
    function withdraw(uint256 num) payable  public isOrOwnerGabay{
       payable(msg.sender).transfer(num);
    }


    function getBalance() public view returns(uint256){
      return address(this).balance;
    }

    function addGabay(address key)public {
      require(owner==msg.sender,"you not owner");
      require(owners[key]==false,"The Gabay already exist"); 
      require(countowners<3 ,"There are already 3 owners");
      owners[key]=true;
      countowners++; 
    }

    function changeGabay(address keyold,address newkey) public {
       require(owner==msg.sender,"you not owner");
       require(keyold != newkey, "Addresses must be different");
       require(owners[keyold]==true,"the key not exist");
       require(owners[newkey]==false,"the key already exist");
       delete(owners[keyold]);
       owners[newkey]=true;
    }
}
