// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {
    address public payer;
    address public payee; 
    address public arbiter;
    uint256 public amount;
    bool public isApproved = false;

    event Deposited(uint256 amount);
    event Approved();
    event Refunded();

    constructor(address _payee, address _arbiter) {
        payer = msg.sender;
        payee = _payee;
        arbiter = _arbiter; 
    }

    function deposit() public payable {
        require(msg.sender == payer, "Onyl payer can deposit"); // if the msg.sender is not payer, the function will display the latter message 
        require(amount > 0, "No funds to approve");

        isApproved = true;
        payable(payee).transfer(amount); // if the fuction isApproved is true, the amount will be transferred to the payee 
        emit Approved();
    }

    function refund() view public {
        require(msg.sender == arbiter, "Only arbiter can refund"); // if the user of the refund function is not the msg.sender, the message will display 
        require(amount > 0, "No funds to refund"); // the format here is 'require(condition, errorMessage)'
                // require(that the amount is greater than zero, if not then the second message will transfer)
        require(!isApproved, "Cannot refund after approval"); 
            // the function checks if the parameters are met - if !isApproved is true, if it is false then the latter message will display 
        payable(payer).transfer(amount);
            // 'payable' signals that the address 'payer' can recieve Ether. Addresses in Solidarity need to be marked as payable to recieve Ether 
        amount = 0;
            // this line resets the amount variable back to zero after the refund has been processed
        emit Refunded(); 
            // emit triggers an event - in this case it triggers the function Refunded
    }
}