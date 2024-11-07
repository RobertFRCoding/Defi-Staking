// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./RobToken.sol";
import "./CatToken.sol";

contract TokenFarm {
    
    // Declaraciones iniciales
    string public name = "Rob Token Farm";
    address public owner;
    RobToken public robToken;
    CatToken public catToken;

    // Estructura de datos
    address [] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    // Constructor 
    constructor(RobToken _robToken, CatToken _catToken) {
        robToken = _robToken;
        catToken = _catToken;
        owner = msg.sender;
    }

    // Stake de tokens
    function stakeToken(uint _amount) public {
        // Se requiere una cantidad mayor a 0
        require(_amount > 0, "La cantidad no puede ser menor a 0");
        // Tranferir ROB al Smart Contract principal
        robToken.transferFrom(msg.sender, address(this), _amount);
        // Actualizar saldo del Staking
        stakingBalance[msg.sender] +=_amount;
        // Guardar el Staker
        if(!hasStaked[msg.sender]){
            stakers.push(msg.sender);
        }

        // Actualizar el estado del staking
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    // Quitar el staking de los tokens
    function unstakeToken() public {
        // Saldo del staking de un usuario
        uint balance = stakingBalance[msg.sender];
        // Se requiere una cantidad superior a 0
        require(balance > 0, "El balance del Staking es 0");
        // Transferencia de los tokens al usuario
        robToken.transfer(msg.sender, balance);
        // Resetea el balance del staking del usuario
        stakingBalance[msg.sender] = 0;
        // Actualiza el estado del staking
        isStaking[msg.sender] = false;
    }

    // Emision de tokens (recompensas)
    function issueToken() public {
        // Unicamente ejecutable por el owner
        require(msg.sender == owner, "No eres el owner");
        // Emitir tokens a t0odos los stakers 
        for (uint i=0; i < stakers.length; i++){
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient];
            if(balance > 0){
                robToken.transfer(recipient, balance);
            }
        }
    }
}
