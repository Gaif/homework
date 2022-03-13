//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Django {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    //账户对应的金额
    mapping (address => uint256) private _blances;

    //授权
    mapping (address => mapping (address => uint256)) private _allowances;


    uint256 private _totalSupple;//总供应量

    //转账事件和授权事件
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor (string memory name, string memory symbol, uint8 decimals, uint total) {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        _mint(msg.sender, total);
    }
    
    //动态增发
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");
        if (amount == 0) {
          return ;
        }

        _totalSupple = _totalSupple + amount;
        _blances[account] = _blances[account] + amount;
        emit Transfer(address(0), account, amount);
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupple;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _blances[account];
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) public returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender]  - amount);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender] + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender] - subtractedValue);
        return true;
    }


    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _blances[sender] = _blances[sender]- amount;
        _blances[recipient] = _blances[recipient] + amount;
        emit Transfer(sender, recipient, amount);
    }

    function _burn(address account, uint256 value) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        _blances[account] = _blances[account] - value;
        _totalSupple = _totalSupple - value;
        emit Transfer(account, address(0), value);
    }


    function _approve(address owner, address spender, uint256 value) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    function _burnFrom(address account, uint256 amount) internal {
        _burn(account, amount);
        _approve(account, msg.sender, _allowances[account][msg.sender] - amount);
    }



}

