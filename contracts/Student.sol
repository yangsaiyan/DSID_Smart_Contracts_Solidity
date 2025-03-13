// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/metatx/ERC2771Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StudentRegistry is ERC2771Context, Ownable {
    struct Student {
        string studentID;
        bool registered;
    }

    mapping(address => Student) private students;

    event StudentRegistered(address indexed student, string studentID);
    event StudentUpdated(address indexed student, string newStudentID);

    constructor(address _trustedForwarder)
        ERC2771Context(_trustedForwarder)
        Ownable(msg.sender)
    {}

    modifier notRegistered() {
        require(!students[_msgSender()].registered, "Already registered");
        _;
    }

    function _contextSuffixLength() internal view virtual override(ERC2771Context, Context) returns (uint256) {
        return ERC2771Context._contextSuffixLength();
    }

    function registerStudent(string memory _studentID) external notRegistered {
        require(bytes(_studentID).length > 0, "Student ID cannot be empty");
        
        students[_msgSender()] = Student(_studentID, true);
        emit StudentRegistered(_msgSender(), _studentID);
    }

    function updateStudent(address _studentAddress, string memory _newStudentID) external onlyOwner {
        require(students[_studentAddress].registered, "Student not found");
        require(bytes(_newStudentID).length > 0, "New Student ID cannot be empty");

        students[_studentAddress].studentID = _newStudentID;
        emit StudentUpdated(_studentAddress, _newStudentID);
    }

    function getStudent(address _studentAddress) external view returns (string memory) {
        require(students[_studentAddress].registered, "Student not found");
        return students[_studentAddress].studentID;
    }

    function _msgSender() internal view override(Context, ERC2771Context) returns (address sender) {
        return ERC2771Context._msgSender();
    }

    function _msgData() internal view override(Context, ERC2771Context) returns (bytes calldata) {
        return ERC2771Context._msgData();
    }
}
