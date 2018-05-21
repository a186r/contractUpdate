pragma solidity ^0.4.17;

import "./Common.sol";

contract a is Common{
    uint public data;
    address public callAddress;

    uint[10] intArray;

    mapping(address => uint) public cam;
    mapping(address => bool) public AllowAccess;

    constructor () public {
        owner = msg.sender;
    }

    function getArray() constant public returns (uint[10]){
        return intArray;
    }

    function f(uint a) external returns(uint b){
        data = a + 2;
        return a+2;
    }

    function f(uint a,address caller) external returns(uint b){
        data = a+2;
        callAddress = caller;
        return 10;
    }

    function setData(uint a) external {
        intArray[0]=12;
        intArray[1]=13;
        intArray[2]=14;
        intArray[3]=15;
        intArray[4]=16;
        intArray[5]=12;
        data = a;
    }

    function getData() external returns(uint) {
        return data;
    }

    function compute(uint a,uint b) external returns (uint) {
        return a + b;
    }

    function setAccess(address key,bool value) internal isOwner{
        AllowAccess[key] = value;
    }

    function getAccess(address key) public view returns(bool){
        return AllowAccess[key];
    }

}