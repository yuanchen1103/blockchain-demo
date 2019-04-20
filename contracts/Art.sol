pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import "./Transaction.sol";

contract Arts {

    struct Art {
      string artName;
      uint artId;
      address owner;
      Transaction[] history;
    }
    Art[] arts;

    mapping(uint => Art) artInfo;
    mapping(uint => Transaction) transactionInfo;

    mapping(uint => address payable) artOwner;

    mapping(address => People) peopleInfo;

    struct People {
      uint id;
      string name;
      Art[] ownedArts;
    }
    
    
    constructor(Art[] memory _array) public {
		  arts = _array;
    }
    
    function getArtInfo(uint _artId) public view returns(uint, string memory, string memory, Transaction[] memory) {
        Art memory art = artInfo[_artId];
        return (art.artId, art.artName, peopleInfo[art.owner].name, art.history);
    }

    function Time_call() public view returns (uint256){
        return now;
    }

    function applyTransaction(uint _transactionId, address payable oldOwner, address payable newOwner, uint art, uint _price) public {
        require(oldOwner != newOwner);
        require(_price > 0);
        require(artInfo[art].owner == oldOwner);
        
        for(uint i = 0; i < peopleInfo[oldOwner].ownedArts.length; i++){
          if(peopleInfo[oldOwner].ownedArts[i].artId == artInfo[art].artId) {
            delete peopleInfo[oldOwner].ownedArts[i];
          }
        }
        peopleInfo[newOwner].ownedArts.push(artInfo[art]);
        Transaction t = (new Transaction)(_transactionId, artInfo[art].artId, artInfo[art].artName, _price, Time_call(), oldOwner, newOwner);
        artInfo[art].history.push(t);
        artInfo[art].owner = newOwner;
    }
    
}