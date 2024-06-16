//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@hack/auction/myERC721.sol";
import "lib/forge-std/src/interfaces/IERC20.sol";

contract Lending{

    struct Borrower{
        uint  amountCollateral;//בטחונות
        uint  amountBorrow;//כמה הלואה
    }
    address public owner;
    IERC20 public  tokenDAI;
    IERC20 public tokenLending;
    IERC20 public tokenETH;
    uint public collateralValue ;//ביטחונות-ETH
    uint public borrowedValue ;//הלואות-
    uint public poolValue;//כמה יש בבריכה-DAI
    mapping(address => uint) public lend;
    mapping(address => Borrower) public borrowers;
    uint public ratio = 0.66;//=1/1.5
    uint ETHvalue = 1000;
    uint wad=10**18;
    uint fee=1.02;
    
     constructor(address _tokenDAI,address _tokenLending,address _tokenETH){
        tokenDAI=IERC20(_tokenDAI);
        tokenLending=IERC20(_tokenLending);
        tokenETH=IERC20(_tokenETH);
        owner=msg.sender;
    }

     modifier isPositive(uint amount) {
        require(amount>0,"must be bigger than zero");
        _; 
    }
////////user///////

    function deposite(uint amount) external isPositive(amount){// Deposits DAI and receives tokens
        tokenDAI.transferFrom(msg.sender,address(this),amount);
        lend[msg.sender] = amount;
        poolValue += amount;
        tokenLending.mint(msg.sender,amount);
    }

    function unbond(uint amount) public isPositive(amount){// Pulls DAI and burns tokens
        require(lend[msg.sender].balance>=amount,"must be less amount");
        tokenDAI.transfer(msg.sender,amount);
        tokenLending.burn(msg.sender,amount);
        lend[msg.sender]-=amount;
        poolValue-=amount;
    }

    function addCollateral(uint amountETH) public payable isPositive(amountETH){ // Brings ETH so he can borrow
        tokenETH.transferFrom(msg.sender,address(this),amountETH);
        collateralValue+=amountETH;
        borrowers[msg.sender].amountCollateral+=amountETH;
    }

    function removeCollateral(uint amountETH) public isPositive(amountETH){
        uint _amountBorrow = borrowers[msg.sender].amountBorrow;//666
        uint sumForPull = (DAIforETH() - _amountBorrow)*wad/(ratio * ETHvalue)*wad;
        require(amountETH>=sumForPull,"you can not pull, dont hava enough borrow");
        tokenETH.transfer(msg.sender,amountETH);
        collateralValue-=amountETH;
        borrowers[msg.sender].amountCollateral-=amountETH;
    }

    function borrow(uint amount) public isPositive(amount){
        uint dai= DAIforETH();
        require(poolValue >= amount,"not enouge money in pool");
        require(dai>=amount+ borrowers[msg.sender].amountBorrow);
        tokenDAI.transfer(msg.sender,amount);
        borrowers[msg.sender].amountBorrow+=amount;
        borrowedValue+=amount;
        poolValue-=amount;
    }

    function returnDAI(uint amount) public isPositive{
        require(amount<= borrowers[msg.sender].amountBorrow);
        borrowers[msg.sender].amountBorrow -= amount;
        tokenDAI.transferFrom(msg.sender,address(this), amount*fee);
        poolValue += amount*fee;
    }


    function DAIforETH() public view returns (uint) {
        return ETHvalue * ratio * borrowers[msg.sender].amountCollateral;
    }

//////////owner////////////

     function trove() public{
         uint prevETH = ETHvalue;
         // ETHvalue = קריאה לפונקציה שבודקת ערך עכשווי
         require(ETHvalue*1.25< prevETH);
         for (uint256 index = 0; index < array.length; index++) {
             sale();
         }
     }

     function harvestRewards()public {
         tokenLending.transfer(address(owner),borrowedValue*0.02);
     }

     function  exchange() public{
         //שולח ל-uniswap
         //uint valueDAI=collateralValue*0.05;
         poolValue+valueDAI;
         collateralValue-=valueDAI;
     }
}




