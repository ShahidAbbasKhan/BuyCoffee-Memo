//SPDX-License-Identifier: Unlicense


pragma solidity ^0.8.0;

contract BuyCoffee {
   
    // Memo struct.
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }
     // Event NewMemo
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    mapping(address=>Memo) Memodetails;
    mapping(address=>uint) public countYourCoffees;
   
    
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function getMemos() public view returns (address,string memory, string memory,uint) {
        return (Memodetails[msg.sender].from,Memodetails[msg.sender].name,Memodetails[msg.sender].message,Memodetails[msg.sender].timestamp);
    }
    function buyCoffee(string memory _name, string memory _message) public payable {
        // ETH should be greater than 0.
        require(msg.value > 0 ether, "can't buy coffee for free");

        // Add the memo to mapping
        Memodetails[msg.sender].from =msg.sender;
        Memodetails[msg.sender].name =_name;
        Memodetails[msg.sender].message =_message;
        Memodetails[msg.sender].timestamp =block.timestamp;
        //
        countYourCoffees[msg.sender] +=1;
        
        // Emit Event
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    //Send balance of contract to Owner address
    function withdrawBalance() public {
        require(msg.sender==owner,"you are not owner");
        (bool done,)=owner.call{value:address(this).balance}("");
        require(done,"Transaction not completed");
    }
     function showBalance() external view returns(uint){
        require(msg.sender==owner,"you are not owner");
        return address(this).balance;
    }
}