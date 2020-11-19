//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.8.0;

contract HashingContract {
    function Hash(address address1, address address2) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(address1, address2));
    }
}