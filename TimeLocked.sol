//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

contract TimeLocked {
    
    using SafeMath for uint256;
    
    address admin;
    
    //This Mapping will save the time to return the funds within 30 days (Only owner can withdraw)
    mapping(address => uint256) time;
    
    event FundsRecieved(address indexed _from, uint _amount);
    event FundsSent(address indexed _beneficiary, uint _amount);
    
    modifier onlyOwner() {
        require(msg.sender == admin);
        _;
    }
    
    constructor() public {
        admin = msg.sender;
        time[msg.sender] = now.add(30 days);
    }
    
    function withdrawFunds(address payable _to, uint _amount) public onlyOwner() {
        require(_amount <= address(this).balance, "Sorry! There are not enough funds stored in the smart contract");
        require(now >= time[_to], "Sorry! You cannot withdraw funds until time is over");
        _to.transfer(_amount);
        emit FundsSent(_to, _amount);
    }
    
    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
    
    receive() external payable {
        emit FundsRecieved(msg.sender, msg.value);        
    }
}