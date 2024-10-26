// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DoubleETH {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Function to fund the contract manually
    function fundContract() external payable {
        require(msg.value > 0, "You need to send some ETH to fund the contract");
    }

    // Function for users to send ETH to get double the amount back
    function doubleETH() external payable {
        require(msg.value > 0, "Send some ETH to double");

        uint256 amountToReturn = msg.value * 2;
        require(address(this).balance >= amountToReturn, "Not enough balance in the contract to double");

        // Send back double the ETH
        (bool success, ) = payable(msg.sender).call{value: amountToReturn}("");
        require(success, "Failed to send ETH back to you");
    }

    // Function for the owner to withdraw all funds if necessary
    function withdrawAll() external {
        require(msg.sender == owner, "Only the owner can withdraw");
        (bool success, ) = payable(owner).call{value: address(this).balance}("");
        require(success, "Withdraw failed");
    }

    // Receive function to accept ETH without triggering doubling
    receive() external payable {}

    // Fallback function to handle unexpected data sent with ETH
    fallback() external payable {}
}
