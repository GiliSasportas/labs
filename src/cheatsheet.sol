// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.15;

interface ITest {
    function payMe() external payable  {}
}
abstract contract TestBase{
    //a virtual function without implement must be implement;
    function nobody() external view virtual ;
//pure- can not to cahnge the static variable and not to read
//view - can not to change the static variable but can to read
//internal-it  means that they can only be accessed from within
// the current contract or its derived contracts ==protected
    function _overridableMePlease(uint a) internal pure virtual returns(uint){
        return a;
    }
// external- call the function only other contract;
function overridableByStateVariable() external virtual returns (uint){
    return 1;
}
// Virtual modifiers can be override but not overloaded.
modifier checker() virtual ;
}
