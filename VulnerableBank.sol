
// VulnerableBank.sol
pragma solidity ^0.8.0;

contract VulnerableBank {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // FUNCIÓN VULNERABLE
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Saldo insuficiente");
        
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transferencia fallida");
        
        balances[msg.sender] -= amount; 
    }
}
