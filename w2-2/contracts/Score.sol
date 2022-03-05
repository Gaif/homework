//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

/*

 编写合约Score，⽤于记录学⽣（地址）分数：
   * 仅有⽼师（⽤modifier权限控制）可以添加和修改学⽣分数
   * 分数不可以⼤于 100； 
* 编写合约 Teacher 作为⽼师，通过 IScore 接⼝调⽤修改学⽣分数

*/

contract Score {
    mapping(address=>uint) studentScore;

    address teacherAdd;
    
    constructor(address _teacherAdd) {
        teacherAdd = _teacherAdd;
    }

    modifier isTeacher() {
      require(msg.sender == teacherAdd);
      _;
    }

    function changeSource(address _studentAddress,uint _changeScore) public isTeacher {

      require(_changeScore<= 100);
      studentScore[_studentAddress] = _changeScore;

    }


  //因为teacher中要使用接口调用修改分数的方法，接口中不能有modifier，所有写了这个方法给Teacher来使用
    function changeStudentSourceNoModifier(address _studentAddress,uint _changeScore) public {
      require(msg.sender == teacherAdd);
      require(_changeScore<= 100);  
      studentScore[_studentAddress] = _changeScore;
    }



}



