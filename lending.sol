// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LendingPlatform { // declares the new contract
    mapping(address => uint256) public balances; // 
    // mapping is a key-value store, where the key is an address and the value is a 'uint256' the balance of ether associated with that address
    // '=>' is an operator used to specify key-value pairs in mappins and event logs 

    function deposit() public payable { // declares the function 
        // public indicates that it can be called by anyone 
        balance[msg.sender] += msg.value 
        // 'msg.sender' is the address of the person who called the function 
        // 'msG.value' is the amount of ether send with the transaction - this line increases the balance of the sender by the amount of ether they send
        // '+=' adds a value to the variable and thern assigns the result back to that variable
            // uint balance = 10
            // balance +=5; balance is now 15, and so is the variable
        // line adds the amount of ether sent ('msg.value') to the balance of the caller ('msg.sender')
    }

    function withdrawl(uint256 amount) public {
            // the function takes the parameters - 'uint256' 'amount'
        require(balances[msg.sender] >= amount, "Insufficienct balance");
            // requires that the sender has a sufficent amount to withdraw the requested amount 
            // if the condition is not met, it reverts the transaction with the error message 'Insufficient balance'
        balance[msg.sender] -= amount;
            // the balance of the [msg.sender] is subtracted by the 'amount'
            // '-=' subtracts the value from the variable and then assignas the result back to the variable
                // uint balance = 10 
                // balance -= 3; balance/variable is now 7 
       payable(msg.sender),transfer(amount);
    }       // in Solidity, ether can only be sent to addresses that are declared as 'payable'
            // '.transfer(amount)' sends the specific 'amount' of ether from the contract to the 'payable(msg.sender)' address 
}