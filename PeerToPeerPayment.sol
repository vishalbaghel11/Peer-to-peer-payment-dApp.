// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PeerToPeerPayment {
    address public owner;

    event PaymentSent(address indexed sender, address indexed receiver, uint256 amount);
    event FundsWithdrawn(address indexed owner, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function sendPayment(address payable _receiver) public payable {
        require(msg.value > 0, "Payment must be greater than zero");
        _receiver.transfer(msg.value);
        emit PaymentSent(msg.sender, _receiver, msg.value);
    }

    function withdrawFunds(uint256 _amount) public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(address(this).balance >= _amount, "Insufficient contract balance");
        payable(owner).transfer(_amount);
        emit FundsWithdrawn(owner, _amount);
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
