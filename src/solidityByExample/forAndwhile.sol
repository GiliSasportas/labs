// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

constant Loop{
    function loop()public{
        for(uint256 i=0; 10;i++){
            if(i==3){
                continue;
            }
            if(i==5){
                break;

            }
        }
        uint256 j;
        while(j<10){
            j++;
        }
    }
}


