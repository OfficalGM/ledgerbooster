pragma solidity ^0.4.24;
import "./Ownable.sol";
import "./Utils.sol";

contract LedgerBooster is Ownable {
    event lostTx(address client,uint currentBlock);
    mapping(address=> Utils.challengedInfo) public challengeLog;
    mapping(uint256=> Utils.treeRecord) public clearanceRecords;
    uint256 public treeNumber;
   
    
    function writeClearanceRecords(bytes32 _rootHash) public onlyOwner returns(uint256)  {
        clearanceRecords[treeNumber++] = Utils.treeRecord(_rootHash);
        return treeNumber-1;
    }
    
    function lostTransaction(bytes32 _rootHash,uint _treeNumber,bytes32 pbPairs,bytes32 _tx,uint8 v,bytes32 r,bytes32 s) public returns(bool) {
        address sender = msg.sender;
        address signature = Utils.verifySignature(_tx,v,r,s);
        if(sender!=signature)
            return false;
        if(_tx!=keccak256(abi.encodePacked(pbPairs)))
            return false;
        if(_rootHash!=clearanceRecords[_treeNumber].rootHash)
            return false;
        uint currentBlock = block.number;
        challengeLog[sender] = Utils.challengedInfo(sender,true,currentBlock,[_rootHash,_tx],_treeNumber);
        emit lostTx(sender,currentBlock);
        return true;
    }
    function spProof(address addr) public view onlyOwner{
        //not finish;
    }
    function propose() public view returns(bool){
        require(challengeLog[msg.sender].challengedState==true,"challengedState is wrong or adddress is wrong");
        require(challengeLog[msg.sender].currentBlock<(block.number+50),"challenge is not finish");
        return true;
    }
    
    
}
