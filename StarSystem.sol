pragma solidity ^0.4.24;

contract StarsList {
    
    uint256 starID;
    uint256 starCount = 0;
    mapping (uint256 => address) userAddress;
    
    // Хранилище для покупки звезд и их наименования
    struct star {
        address starOwner;
        string starName;
        string starColor;
    }

    mapping(uint256 => star) Stars;

    event transfer(address from, address to, uint256 starID);
    event changeColor(uint256 starID, string);
    event changeName(uint256 starID, string);
    
    function CreateStar(string _starName, string _starColor) public returns (bool){
        starID = starCount++;
        Stars[starID].starOwner = msg.sender;
        Stars[starID].starName = _starName;
        Stars[starID].starColor = _starColor;
        return true;
    }
    
    function Transfer(address _to, uint256 _starID) public {
        require(Stars[_starID].starOwner == msg.sender);
        Stars[_starID].starOwner = _to;
        
        emit transfer(msg.sender, _to, _starID);
    }
    
    function ChangeStarColor(uint256 _starID, string _starColor) public returns (bool) {
        require(Stars[_starID].starOwner == msg.sender);
        Stars[_starID].starColor = _starColor; 
        
        emit changeColor(_starID, _starColor);
        return true;
    }
    
    function ChangeStarName(uint256 _starID, string _starName) public returns (bool) {
        require(Stars[_starID].starOwner == msg.sender);
        Stars[_starID].starName = _starName;   
        
        emit changeName(_starID, _starName);
        return true;
    }
    
}