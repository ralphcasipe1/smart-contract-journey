//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Greeter {
    mapping(address => uint256) public ownerToLuckyNumber;
    
    string private greeting;

    constructor() {
        console.log("Deploying a Greeter with greeting: ", msg.sender);
    }

    modifier luckyNumberGuard() {
        require(
            ownerToLuckyNumber[msg.sender] == 0,
            "You already have a lucky number."
        );
        _;
    }

    modifier luckyNumberNotZero(uint256 _luckyNumber) {
        require(_luckyNumber != 0, "Lucky number should not be 0.");
        _;
    }

    modifier shouldMatchPreviousLuckyNumber(uint256 _luckyNumber) {
        require(
            ownerToLuckyNumber[msg.sender] == _luckyNumber,
            "Not your previous lucky number."
        );
        _;
    }

    function saveLuckyNumber(uint256 _luckyNumber) external luckyNumberGuard luckyNumberNotZero(_luckyNumber) {
        ownerToLuckyNumber[msg.sender] = _luckyNumber;
    }

    function sum(uint256 a, uint256 b) public pure returns(uint256) {
        return a + b;
    }

    function getMyLuckyNumber() external view returns (uint256) {
        return ownerToLuckyNumber[msg.sender];
    }

    function updateLuckyNumber(uint256 _luckyNumber, uint256 _newLuckyNumber) external shouldMatchPreviousLuckyNumber(_luckyNumber) {
        ownerToLuckyNumber[msg.sender] = _newLuckyNumber;
    }
    
    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }
}
