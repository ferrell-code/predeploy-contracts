// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.5.0;

library MultiCurrency {
  function totalIssuance(uint256 currencyId) internal returns(uint256[1] memory p) {
      uint256[1] memory input;

      uint256 x = 0 << 32;
      x += currencyId;

      input[0] = x << 216;

      assembly {
        if iszero(staticcall(gas, 0x0000000000000000001, input, 0x20, p, 0x20)) {
            revert(0,0)
        }
      }
      return p;
  }

  function balance(uint256 currencyId, uint256 addr) internal returns(uint256[1] memory p) {
      uint256[2] memory input;

      uint256 x = 1 << 32;
      x += currencyId;

      input[0] = x << 216;
      input[1] = addr << 96;

      assembly {
        if iszero(staticcall(gas, 0x0000000000000000001, input, 0x40, p, 0x20)) {
            revert(0,0)
        }
      }
      return p;
  }

  function transfer(uint256 currencyId, uint256 src, uint256 dest, uint256 amount) internal {
      uint256[4] memory input;

      uint256 x = 2 << 32;
      x += currencyId;

      input[0] = x << 216;
      input[1] = src << 96;
      input[2] = dest << 96;
      input[3] = amount << 128;

      assembly {
        if iszero(staticcall(gas, 0x0000000000000000001, input, 0x80, 0x00, 0x00)) {
            revert(0,0)
        }
      }
  }
}
