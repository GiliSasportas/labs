// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;


contract Collectors{

    address public owner;
     mapping(address => bool) public collectors;
     uint public countCollectors=0;

    constructor(){
        owner=msg.sender;
    }

    receive()external payable {}


    modifier isOrOwnerCollector() {
       require(collectors[msg.sender]==true || msg.sender==owner,"not owner or collector");
        _; 
    }
       
   function withdraw(uint256 num) payable  public isOrOwnerCollector{
     payable(msg.sender).transfer(num);
   }


   function getBalance() public view returns(uint){
    return address(this).balance;
   }

   function addCollector(address key)public {
    require(owner==msg.sender,"you not owner");
    require(collectors[key]==false,""); 
   if(countCollectors<3){
      collectors[key]=true;
      countCollectors++;
    }
    else{
      revert("There are already 3 collectors");
    }
   }

   function changeCollector(address keyold,address newkey) public {
       require(owner==msg.sender,"you not owner");
       require(collectors[keyold]==true,"the key not exist");
       require(collectors[newkey]==false,"the key already exist");
        collectors[keyold]=false;
        collectors[newkey]=true;
       
}

}
