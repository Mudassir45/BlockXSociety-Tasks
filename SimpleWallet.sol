// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

contract SimpleWallet is Ownable {
    
    using SafeMath for uint256;
    
    event PaymentRecieved(address indexed _from, uint _amount);
    event PaymentSent(address indexed _beneficiary, uint _amount);
    
    function withdrawPayment(address payable _to, uint _amount) public onlyOwner(){
        require(_amount <= address(this).balance, "There are not enough funds stored in the smart contract");
        _to.transfer(_amount);
        emit PaymentSent(_to, _amount);
    }
    
    function renounceOwnership() public override {
        revert("Can not renounce ownership here.");
    }
    
    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
    
    receive() external payable {
        emit PaymentRecieved(msg.sender, msg.value);        
    }
}