// SPDX-License-Identifier: MIT

pragma solidity ^0.6.2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

contract Todo is Ownable {
    using Counters for Counters.Counter;
    using SafeMath for uint256;
    
    Counters.Counter taskCount;
    
    struct Task {
        uint256 id;
        string content;
        bool isCompleted;
    }
    
    mapping(uint256 => Task) public tasks;
    
    event TaskCreated(uint id, string content, bool isCompleted);
    event TaskCompleted(uint id, bool isCompleted);
    
    function createTask(string calldata _content) public {
        taskCount.increment();
        tasks[taskCount.current()] = Task(taskCount.current(), _content, false);
        emit TaskCreated(taskCount.current(), _content, false);
    }
    
    function taskCompleted(uint _id) public {
        Task memory task = tasks[_id];
        task.isCompleted = true;
        tasks[_id] = task;
        emit TaskCompleted(_id, task.isCompleted);
    }
}