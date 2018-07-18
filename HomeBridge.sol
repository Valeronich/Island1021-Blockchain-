pragma solidity ^0.4.24;

contract StarsList {
    function getSerializedData(uint256 _starID) public returns(bytes32[] data);
    function recoveryToken(uint256 _starID, bytes32[] _data);
    function Transfer(address _to, uint256 _starID, bytes32[] _data) public;
    function safeTransferFrom(address _from, address _to, uint256 _starID) public;
}

contract HomeBridge {
    
    constructor(address _addr) public {
        HomeBridgeAddr = _addr;
    }
    
    
    address HomeBridgeAddr;
    
    StarsList starlist = StarsList(HomeBridgeAddr);
    
    event userRequestForSignature(uint _starID, bytes32[] _data);
    event transferCompleted(uint256 _starID);
    
    function onERC721Received(address _from, address _to, uint256 _starID, bytes32[] _data) public returns (bytes4) {
        starlist = StarsList(_from);
        //starlist.getSerializedData(_starID);
        emit userRequestForSignature(_starID, starlist.getSerializedData(_starID));
        return bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
    }
    function transferApproved(address _owner, uint256 _starID, bytes32[] _data) {
        starlist.recoveryToken(_starID, _data);
        starlist.Transfer(_owner, _starID, _data);
        emit transferCompleted(_starID);
        
    }
}