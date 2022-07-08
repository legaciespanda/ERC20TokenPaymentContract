// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ECommerce {
    IERC20 token;
    address private owner;

    constructor() public {
        token = IERC20(0x62D62D73C27E6240165ee3A97C6d1532c0dD0b42);
        // this token address is LINK token deployed on Rinkeby testnet
       // You can use any other ERC20 token smart contarct address here
        owner = msg.sender;
    }
    
    
    modifier OnlyOwner() {
        require(msg.sender == owner);
        _;
    }

  
   function GetUserTokenBalance() public view returns(uint256){ 
       return token.balanceOf(msg.sender);// balancdOf function is already declared in ERC20 token function
   }
   
   
   function Approvetokens(uint256 _tokenamount) public returns(bool){
       token.approve(address(this), _tokenamount);
       return true;
   }
   
   
   function GetAllowance() public view returns(uint256){
       return token.allowance(msg.sender, address(this));
   }
   
   function AcceptPayment(uint256 _tokenamount) public returns(bool) {
       require(_tokenamount > GetAllowance(), "Please approve tokens before transferring");
       token.transfer(address(this), _tokenamount);
       return true;
   }
   
   
   function GetContractTokenBalance() public OnlyOwner view returns(uint256){
       return token.balanceOf(address(this));
   }
   
}
