pragma solidity ^0.4.24;

library Utils{
    struct challengedInfo{
        address client;
        bool challengedState; 
        uint256 currentBlock;
        bytes32[2] hash;//0:rootHash 1:Tx
        uint256 treeNumber;
    }
    struct treeRecord {
        bytes32 rootHash;
        uint256 treeNumber;
        uint256 classification;
    }
    function verifySignature(bytes32 hash, uint8 v, bytes32 r, bytes32 s) public pure returns(address retAddr) {
        retAddr = ecrecover(hash, v, r, s);
        return retAddr;
    }
    function calculateRootHash(uint idx,bytes32[] slice) public pure returns(bool) {
        require(slice.length > 0, "slice.length = 0");
        bytes32 temp;
        uint index = idx;
        bool b = false;
        for(uint i = slice.length-1;i>1;i = i/2) {
            index = index/2;
            temp = keccak256(abi.encodePacked(slice[i-1],slice[i]));
            b = compareByte(slice[index-1],temp);
        }
        return b;
    } 
    function compareByte(bytes32 _h,bytes32 _s) internal pure returns(bool){
        for(uint i = 0;i<32;i++){
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
    function mergeBytes(bytes memory a, bytes memory b) internal pure returns (bytes memory c) {
        uint alen = a.length;
        uint totallen = alen + b.length;
        uint loopsa = (a.length + 31) / 32;
        uint loopsb = (b.length + 31) / 32;
        assembly {
            let m := mload(0x40)
            mstore(m, totallen)
            for {  let i := 0 } lt(i, loopsa) { i := add(1, i) } { mstore(add(m, mul(32, add(1, i))), mload(add(a, mul(32, add(1, i))))) }
            for {  let i := 0 } lt(i, loopsb) { i := add(1, i) } { mstore(add(m, add(mul(32, add(1, i)), alen)), mload(add(b, mul(32, add(1, i))))) }
            mstore(0x40, add(m, add(32, totallen)))
            c := m
        }
    }
}