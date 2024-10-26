// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DoubleETH {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Function to double the amount of ETH sent
    function doubleETH() external payable {
        require(msg.value > 0, "Send some ETH to double");

        uint256 amountToReturn = msg.value * 2;
        require(address(this).balance >= amountToReturn, "Not enough balance in the contract");

        // Send back double the ETH
        (bool success, ) = msg.sender.call{value: amountToReturn}("");
        require(success, "Transfer failed.");
    }

    // Allow contract to receive ETH
    receive() external payable {}
}
