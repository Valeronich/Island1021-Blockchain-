pragma solidity ^0.4.24;

contract AlienToken {
    function getSerializedData(uint256 _starID) public returns (bytes32[]);
    function recoveryToken(uint256 _starID, bytes32[] _tokenData) public;
    function transfer(uint256 _starID, address _to) public;
    function deleteStar(uint _starID) public;
}

contract AlienBridge {
    
    constructor(address _addr) public{
            homeContractAddr = _addr;
        }
        
    address homeContractAddr;
        
        AlienToken alienToken = AlienToken(homeContractAddr);
        
        event userRequestForSignature(uint _starID, bytes32[] _data);

    function onERC721Received(address _operator, address _from, uint256 _starID, bytes32[] _data) external returns(bytes4){
            emit userRequestForSignature(_starID, alienToken.getSerializedData(_starID));
            alienToken.deleteStar(_starID);
            return bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
        }   
    event transferCompleted(uint _tokenId);
        
        function transferApproved(address _owner, uint256 _starID, bytes32[] _data){
            alienToken.recoveryToken(_starID, _data);
            alienToken.transfer(_starID, _owner);
            emit transferCompleted(_starID);    }
    
}


