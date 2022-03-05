//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IScore {    
    function changeSource(address _studentAddress,uint _changeScore) external;
}

contract Teacher {
    IScore public score;

    function changeStudentScore(address _studentAddress,uint _changeScore) public {
        score.changeSource(_studentAddress, _changeScore);
    }
}