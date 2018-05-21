pragma solidity ^0.4.17;
contract Common{
    address public owner;

    modifier isOwner{
        if (msg.sender == owner) _;
        else {
            return;
        }
    }

    function setOwner(address newOwner) isOwner public {
        owner = newOwner;
    }

}