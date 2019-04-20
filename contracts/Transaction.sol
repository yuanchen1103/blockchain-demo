pragma solidity ^0.5.0;

contract Transaction {
  uint transactionId;
  uint artId;
  string artName;
  uint price;
  uint256 date;
  address payable old_owner;
  address payable new_owner;
  constructor(uint _transactionId, uint _artId, string memory _artName, uint _price, uint256 _date, address payable _old_owner, address payable _new_owner) public {
    transactionId = _transactionId;
    artId = _artId;
    artName = _artName;
    price = _price;
    date = _date;
    old_owner = _old_owner;
    new_owner = _new_owner;
  }
  

  function getTransactionInfo() public view returns(uint, uint, string memory, uint, uint256, address, address) {
    return (transactionId, artId, artName, price, date, old_owner, new_owner);
  }
}