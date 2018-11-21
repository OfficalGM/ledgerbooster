pragma solidity ^0.4.22;
import './Ownable.sol';
contract Auth is Ownable {
    mapping(uint256=>Tree) public tree;
    uint256 public TreeNumber;
    struct Tree {
        bytes32 RootHash;
    }
    function verify(bytes32 hash, uint8 v, bytes32 r, bytes32 s) public pure returns(address retAddr) {
        retAddr= ecrecover(hash, v, r, s);
        return retAddr;
    }
    function setTree(bytes32 _roothash) public onlyOwner returns(uint256)  {
        tree[TreeNumber++]=Tree(_roothash);
        return TreeNumber-1;
    }
    function sliceRootHash(uint idx,bytes32[] slice) public pure returns(bool) {
        require(slice.length > 0, "slice.length = 0");
        bytes32 temp;
        uint index=idx;
        bool b=false;
        for(uint i=slice.length-1;i>1;i=i/2) {
            index=index/2;
            temp=keccak256(abi.encodePacked(slice[i-1],slice[i]));
            b=compareByte(slice[index-1],temp);
        }
        return b;
    } 
    
    function compareByte(bytes32 _h,bytes32 _s) internal pure returns(bool){
        for(uint i=0;i<32;i++){
            if(_s[i]!=_h[i]){
                 return false;
            }
        }
        return true;
    }
    function strConcat(string _a,string _b) internal pure returns (string) {
        bytes memory bytes_a = bytes(_a);
        bytes memory bytes_b = bytes(_b);
        string memory length_ab = new string(bytes_a.length + bytes_b.length);
        bytes memory bytes_c = bytes(length_ab);
        uint k = 0;
        for (uint i = 0; i < bytes_a.length; i++) {bytes_c[k++] = bytes_a[i];}
        for (i = 0; i < bytes_b.length; i++) {bytes_c[k++] = bytes_b[i];}
        return string(bytes_c);
    }
    function bytes32ToString(bytes32 x) internal pure returns (string) {
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
    }
    function stringToBytes32(string memory source) internal pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        assembly {
            result := mload(add(source, 32))
        }
    }
}