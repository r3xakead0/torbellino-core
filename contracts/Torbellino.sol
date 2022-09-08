// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Torbellino {

    mapping(string => uint) private ordenBook;

    event Deposit(address indexed user, uint amount, uint timeStart);
    event Withdraw(address indexed user, uint amount, uint timeStart);

    constructor() payable {
    }

    function deposit(string memory _memo) public payable {
        require(ordenBook[_memo] == 0, "Memo is not valid");
        ordenBook[_memo] = msg.value;

        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(address payable _to, string memory _memo) public {
        require(msg.sender != _to, "You can't send money to yourself!");

        uint amount = getMemoBalance(_memo);
 
        (bool success, ) = _to.call{value: amount, gas: 35000}("");
        require(success, "Failed Withdrawal");
        
        ordenBook[_memo] = 0;

        emit Withdraw(_to, amount, block.timestamp);
    }

    function getTotalBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getMemoBalance(string memory _memo) public view returns (uint) {
        require(ordenBook[_memo] > 0, "Memo doesn't exists");
        return ordenBook[_memo];
    }
}
