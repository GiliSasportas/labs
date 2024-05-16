//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@hack/auction/myERC721.sol";

contract Lending{


    struct Borrower{
        uint  amountCollateral;//בטחונות
        uint  amountBorrow;//כמה הלואה
    }
    
    IERC20 public  tokenDAI;
    IERC20 public tokenLending;
    IERC20 public tokenETH;
    //uint public borrowLimit ;
    uint public collateralValue ;//ביטחונות-ETH
    uint public borrowedValue ;//הלואות-
    //uint public maxLTV ;
   // uint public borrowRate;
    uint public poolValue;//כמה יש בבריכה-DAI
    mapping(address => uint) public lend;
    mapping(address => Borrower) public borrowers;
    uint public ratio = 3;

     constructor(address _tokenDAI,address _tokenLending,address _tokenETH){
        tokenDAI=IERC20(tokenErc20);
        tokenLending=IERC20(tokenErc20);
        tokenETH=IERC20(tokenErc20);
    }

     modifier isPositive(uint amount) {
        require(amount>0,"must be better than zero");
        _; 
    }

    function deposite(uint amount) external isPositive(amount){
        tokenDAI.transferFrom(msg.sender,address(this),amount);
        lend[msg.sender] = amount;
        poolValue += amount;
        //amount-?
        tokenLending.mint(msg.sender,amount);
    }

    function unbond(uint amount) public isPositive(amount){
        require(lend[msg.sender].balance>=amount,"must be less amount");
        tokenDAI.transfer(msg.sender,amount);
        tokenLending.burn(msg.sender,amount);
        lend[msg.sender]-=amount;
        poolValue-=amount;
    }

    function addCollateral(uint amountETH) public isPositive(amountETH){
        tokenETH.transferFrom(msg.sender,address(this),amountETH);
        collateralValue+=amount;
        borrowers[msg.sender].amountCollateral+=amountETH;
    }

    function removeCollateral(uint amountETH) public isPositive(amountETH){
        tokenETH.transfer(msg.sender,amountETH);
        collateralValue-=amount;
        borrowers[msg.sender].amountCollateral-=amountETH;
    }

    function borrow(uint amount) public isPositive(amount){
        //כמה זה שווה באמת ב-DAI
        require(poolValue >= amount,"not enouge money in pool");
        tokenDAI.transfer(msg.sender,amount);
        borrowers[msg.sender].amountBorrow+=amount;
        borrowedValue+=amount;
        poolValue-=amount;
    }

    function returnDAI(uint amount) public isPositive{
        require(amount<= borrowers[msg.sender].amountBorrow);
        borrowers[msg.sender].amountBorrow -= amount;
        tokenDAI.transferFrom(msg.sender,address(this), amount);
        poolValue += amount;
    }

    
}




