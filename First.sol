
//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract UniDAOWeek2 {
    address payable public owner;
    address payable public beneficiary;
    uint256 public lastCheckIn;
    uint256 public checkInPeriod = 10;

    constructor(address payable _beneficiary) {
        owner = payable(msg.sender);
        beneficiary = _beneficiary;
        lastCheckIn = block.number;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can access perform this action.");
        _;
    }

    function still_alive() public onlyOwner {
        lastCheckIn = block.number;
    }

    function getBalance() public view onlyOwner returns(uint) {
        return address(this).balance;
    }

    function checkAndDestroy() public onlyOwner {
        require(block.number > lastCheckIn + checkInPeriod, "Owner has checked in recently.");
        beneficiary.transfer(address(this).balance);
    }

    function getCurrentBlock() public view returns(uint) {
        return block.number;
    }
}
