pragma solidity ^0.4.24;

import "./Ownable.sol";
import "./Util.sol";

contract LedgerBooster is Ownable {
    event lostTx(address client,uint currentBlock);
    mapping(address=> Util.challengedInfo) public challengeLog;
    mapping(uint256=> Util.treeRecord) public clearanceRecords;
    uint256 public treeNumber;
   
    function writeClearanceRecords(bytes32 _rootHash,uint256 classification) public onlyOwner   {
        clearanceRecords[treeNumber++] = Util.treeRecord(_rootHash,treeNumber,classification);
    }
    
    function lostTransaction(bytes32 _rootHash,uint _treeNumber,bytes32 pbPairs,bytes32 _tx,uint8 v,bytes32 r,bytes32 s) public{
        address sender = msg.sender;
        address signature = Util.verifySignature(_tx,v,r,s);
        require(sender!=signature,"signature is error");
        require(_tx!=keccak256(abi.encodePacked(pbPairs)),"tx is wrong");
        require(_rootHash!=clearanceRecords[_treeNumber].rootHash,"roothash is error");
        uint currentBlock = block.number;
        challengeLog[sender] = Util.challengedInfo(sender,true,currentBlock,[_rootHash,_tx],_treeNumber);
        emit lostTx(sender,currentBlock);
        
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
