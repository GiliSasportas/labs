// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract DataLocations{
    uint[] public arr;
    mapping(uint=> address) public m;
    Struct myStruct{
        uint num;
    }
    mapping(uint=> myStruct) public mp;
    function f(
        uint[] storage arr,
        mapping(uint=>address) storage m,
        mapping(uint=>mapping(uint=>myStruct))storage mp;
    ) internal{
    }
    function _f()public{
        f(arr,m,mp);
    }
}