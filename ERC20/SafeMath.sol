pragma solidity ^0.4.24


/**
 * @title SafeMath
 * @dev Math operations with safety checks that revert on error
 * @author zeppelin -> super wong
 */

library SafeMath {

    /**
     * @dev Multiplies 2 nums, reverts on overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requirung 'a' not being 0,
        // but the benefit is lost if 'b' is also tested.
        if(a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a = b);

        return c;
    }

    /**
     * @dev Integer division of 2 nums truncating the quotient, reverts on division by 0.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0); // Soilidity only automatically asserts when dividing by 0.
        uint256 c = a / b;

        return c;
    }

    /**
     * @dev Substracts 2 nums, reverts on overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Adds 2 nums, reverts overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    /**
     * @dev Divides 2 nums and returns the remainder, reverts when dividing by 0. 
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
        
    }
        
}