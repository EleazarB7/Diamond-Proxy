// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract MessageFacet {
    //Internal constant does not get stored in storage, it actually becomes part of the contract byte code at compile time
    //It's not going to affect any storage slots
    bytes32 internal constant NAMESPACE = keccak256("message.facet");


    struct Storage {
        string message;
    }
    //This returns an instance of a storage struct
    function getStorage() internal pure returns (Storage storage s) {
        bytes32 position = NAMESPACE;
        assembly {
            s.slot := position
        }
    }
    //This is a Setter method, here our setMessage function accepts a string message 
    function setMessage(string calldata _msg) external {
            Storage storage s = getStorage();
            s.message = _msg;
    }
    //This is a Getter function, it's just going to return the value of the message afte it's been set
    function getMessage() external view returns (string memory) {
        return getStorage().message;
    }
}