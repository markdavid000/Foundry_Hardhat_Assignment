# Deployed Contract Addresses

### Lisk Sepolia Contract Address (Hardhat)
```0x20d4Bec324556Cf8ec7F972F09B0F01373e1f1CD```

### Lisk Sepolia Contract Address (Foundry)
```0xb110f0785009a46d6fc98D1B43e1B7B6662EAE6f```

### Arc Testnet Contract Address (Hardhat)
```0xB016b136a008F210Ca1D7855B2D792628c635BFC```

### Arc Testnet Contract Address (Foundry)
```0x3f3e7041cd240279700377D8De1a7696a57EBC65```

### Foundry Test Cases
    [⠒] Compiling...
    [⠊] Compiling 1 files with Solc 0.8.25
    [⠒] Solc 0.8.25 finished in 1.91s
    Compiler run successful!
    
    Ran 9 tests for test/Owner.t.sol:OwnerTest
    [PASS] testChangeOwnerRevertsIfNotOwner() (gas: 16248)
    [PASS] testChangeOwnerRevertsIfZeroAddress() (gas: 14139)
    [PASS] testConstructorEmitsOwnerSetEvent() (gas: 302183)
    [PASS] testConstructorSetsOwnerCorrectly() (gas: 10147)
    [PASS] testFuzzCallerMustBeOwner(address,address) (runs: 256, μ: 22216, ~: 22216)
    [PASS] testFuzzChangeOwner(address) (runs: 256, μ: 20058, ~: 20058)
    [PASS] testGetOwnerWorks() (gas: 10156)
    [PASS] testNewOwnerCanChangeOwnerAgain() (gas: 27875)
    [PASS] testOwnerCanChangeOwner() (gas: 24196)
    Suite result: ok. 9 passed; 0 failed; 0 skipped; finished in 51.08ms (60.59ms CPU time)
    
    Ran 1 test suite in 528.12ms (51.08ms CPU time): 9 tests passed, 0 failed, 0 skipped (9 total tests)

### Hardhat Test Cases
    Owner Contract
    Owner contract deployed by: 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
        ✔ Should set the deployer as the initial owner (64ms)
    Owner contract deployed by: 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
    Owner contract deployed by: 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
        ✔ Should emit OwnerSet event on deployment (128ms)
    Owner contract deployed by: 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
        ✔ Should return the correct owner
    Owner contract deployed by: 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
        ✔ Owner should be able to change owner
    Owner contract deployed by: 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
        ✔ Should emit OwnerSet event on owner change
    Owner contract deployed by: 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
        ✔ Should revert if non-owner tries to change owner (78ms)
    Owner contract deployed by: 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
        ✔ Should revert if new owner is zero address
    Owner contract deployed by: 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
        ✔ New owner should be able to change ownership again (54ms)
    
    
      8 passing (1s)
    
    ·············································································································
    |  Solidity and Network Configuration                                                                       │
    ························|·················|···············|·················|································
    |  Solidity: 0.8.24     ·  Optim: false   ·  Runs: 200    ·  viaIR: false   ·     Block: 60,000,000 gas     │
    ························|·················|···············|·················|································
    |  Methods                                                                                                  │
    ························|·················|···············|·················|················|···············
    |  Contracts / Methods  ·  Min            ·  Max          ·  Avg            ·  # calls       ·  usd (avg)   │
    ························|·················|···············|·················|················|···············
    |  Owner                ·                                                                                   │
    ························|·················|···············|·················|················|···············
    |      changeOwner      ·         28,822  ·       28,834  ·         28,830  ·             6  ·           -  │
    ························|·················|···············|·················|················|···············
    |  Deployments                            ·                                 ·  % of limit    ·              │
    ························|·················|···············|·················|················|···············
    |  Owner                ·              -  ·            -  ·        350,962  ·         0.6 %  ·           -  │
    ························|·················|···············|·················|················|···············
    |  Key                                                                                                      │
    ·············································································································
    |  ◯  Execution gas for this method does not include intrinsic gas overhead                                 │
    ·············································································································
    |  △  Cost was non-zero but below the precision setting for the currency display (see options)              │
    ·············································································································
    |  Toolchain:  hardhat                                                                                      │
    ·············································································································
