// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {
    address public buyer;
    address: payable public seller;
    address public escrowAgent;
    uint public amount; //uint short for uint256, used to store numerical values 
        // public allows anyone to read the value outside of the contract 
    bool public buyerApproval; //stores if approval has been met by the buyer
    bool public sellerApproval; //stores if approval has been met by the seller

    constructor(address _buyer, address payable _seller, uint _amount) {
        // constructor si executed when the contract is deployed to the blockchain - sets up the initial state of the contract 
        // payabel allows the contract to send the seller the ether
        buyer = _buyer
        seller = _seller 
        escrowAgent = msg.sender; // the deployer of the contract becomes the escrow agent 
        amount = _amount; 
    }

    //function to deposit the escrow amount by the buyer 
    function deposit() external payable { //external allows the function to be called from outside the contract 
    // payable allow it to accept ether 
        require(msg.sender == buyer, "Only the buyer can deposit funds");
            // ensures that only the buyer can deposit funds into the contract
        require(msg.value == amount, "Incorrect deposit amount");
            // ensures the deposited amount is equal to the 'amount' set in the contact
    }

    // function for the buyer to approve the transaction 
    function approveTransactionByBuyer() external {
        require(msg.sender == buyer, "Only the buyer can approve the transaction");
        buyerApproved = true;
        completeTransaction();
    }

    // function for the seller to approve the transaction 
    function approveTransactionBySeller() external {
        require(msg.sender == seller, "Only the seller can approve the transaction");
        sellerApproved = true;
        completeTransaction();
    }

    // function to complete the transaction if both parties have approved
    function completeTransaction() external {
        if (buyerApproved && sellerApproved) {
            seller.transfer(amount);
        }
    }

    // function for the escrow agent to resolve desputes
    function resolveDispute(bool _releaseFundsToSeller) external {
        require(msg.sender == escrowAgent, "Only the escrow agent can resolve disputes");
        if (_releaseFundsToSeller) {
            seller.transfer(amount);
        }   else [
            payable(buyer).transfer(amount);
        ]
    }

    // function to refund buyer if the transaction is not approved
        function refundBuyer() external {
            require(msg.sender == escrowAgent, "Only the ecrow agent can refund the buyer");
            require(!buyerApproved || !sellerApproved, "Transaction alread approved");
            payable(buyer).transfer(amount);
        } 
}