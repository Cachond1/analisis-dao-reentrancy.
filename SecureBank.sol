
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract SecureBank is ReentrancyGuard {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // FUNCIÓN SEGURA
    function withdraw(uint256 amount) public nonReentrant {
        require(balances[msg.sender] >= amount, "Saldo insuficiente");
        
        balances[msg.sender] -= amount; 
        
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transferencia fallida");
    }
}
