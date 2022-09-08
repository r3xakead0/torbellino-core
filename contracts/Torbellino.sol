// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Torbellino {
    mapping(string => uint) private orderBook;

    event Deposit(address indexed user, uint amount, uint timeStart);
    event Withdraw(address indexed user, uint amount, uint timeStart);

    constructor() payable {
    }

    function deposit(string memory _order) public payable {
        require(orderBook[_order] == 0, "Order is already created. You need to finish the withdrawal process.");
        orderBook[_order] = msg.value;

        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(address payable _to, string memory _order) public {
        require(msg.sender != _to, "You can't send money to yourself!");

        uint amount = getMemoBalance(_order);
 
        (bool success, ) = _to.call{value: amount, gas: 35000}("");
        require(success, "Failed Withdrawal");
        
        orderBook[_order] = 0;

        emit Withdraw(_to, amount, block.timestamp);
    }

    function getTotalBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getOrderBalance(string memory _order) public view returns (uint) {
        require(orderBook[_order] > 0, "Order doesn't exists.");
        return orderBook[_order];
    }
}
