# Week 1: 以太坊代币合约分析

## 00 上周工作情况

- 货币金融学、货币发展历史
- 以太坊代币体系的发展
- ERC-20 协议梳理、测试、分析

## 01 以太坊代币体系梳理

### 1.1 以太坊

目前我对以太坊平台的理解为：

- 区块链 2.0
- 价值网络
- 分布式计算系统

### 2.2 代币系统

ETH：以太坊区块链（Ethereum Block Chain）中用于交换的一般等价物，是区块链**价值网络**的体现，使用该网络提供的服务需要支付 ETH。

智能合约与 Dapp：按照以太坊的定义，将以太坊看作是一个**分布式计算系统**的话，运行在以太坊区块链上的智能合约（Smart Contract）可以看作是一个个的分布式应用程序（Distribution App，Dapp）。

总结：**在以太坊上运行智能合约需要支付 ETH**。

### 2.3 代币合约

另一方面，在每个Dapp中开发者也可以定义自己的价值体系，为其提供的服务定义等价物（而不一定是ETH），不同的等价物构成了不同的 token。

举例来说，小明去赌场梭哈需要使用现实世界中的法定货币（人民币，美元等）购买在赌场环境中流通的筹码（token），筹码用于购买赌场的服务和满足赌场内部的流通与交换，小明也可以随时将筹码兑换为法定货币（套现）。

总结：**使用智能合约提供的服务可能需要使用合约指定的代币。**

由于以太坊上众多 Dapp 都有发行自己代币的需求，而不同开发者对**代币合约**的实现各不相同，后来开发者逐渐接受了一个统一的代币实现提案——ERC-20。

ERC-20主要解决了下面几个问题：

- 简化开发
- 提供统一的合约接口，增强代币流通性



从开发的角度来看，以太坊ERC-20 代币协议其实是一种特殊的智能合约——代币合约，因此其实现中有很多合约的特点在里面。

## 02 ERC-20 协议分析

### 2.1 协议接口分析

ERC-20 协议提供了：

- 3个可选参数
- 6个基本方法/接口
- 2种事件记录机制

```solidity
// 3 个可选参数
string public name = "KB109-Token";
string public symbol = "KBT";
uint8 public decimals = 8; // 0~18

// 6 个基本接口
interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address who) external view returns (uint256);

    function allwance(address owner, address spender) external view returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(address from, address to, uint256 value) external returns (bool);
	// 2 种事件记录机制
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, indexed spender, uint256 value);
}
```

6 种方法又可以分类如下：

- 查询接口：`totalSupply`：查询代币总发行量，`balanceOf`：查询账户余额，`allowance`：查询授权配额
- 动作接口：`transfer`：直接转账，`transferFrom`：授权转账
- 授信接口：`approve`：授权



在协议实现中，还需要增加：

-  1 个全局变量用于记录代币发行量
- 2 张哈希表（账本），用于记账

```
 uint256 public _totalSupply; // 代币发行数量，以 decimals 为最小不可分割单位
 
mapping(address => uint256) private _balances; // 余额：一维数组
mapping(address => mapping (address => uint256)) private _allowed; // 配额：二维数组
```

### 2.2 协议交互逻辑

### 2.3 记账操作

ERC-20 代币系统中的转账分为两种：

- 由转账人直接发起的转账；
- 由转账人授权第三方发起的转账。

具体过程如下：

- 直接转账：Alice 向 Bob 转账 10 Token

```
Alice.transfer(Bob, 10) {
	require(balanceOf(Alice) > 10)
	balances[Alice] -= 10
	balances[Bob] += 10
}
```

1. 由 Alice 调用 transfer 方法
2. 合约检查 余额表中 Alice 账户余额是否充足；
3. 合约调整余额表上 Alice 和Bob 的余额。

- 间接转账：Alice 向 合约 授权，向 Bob 转账 10 Token

```
Alice.approve(Bob, 10)
contract.transferFrom(Alice, Bob, 10) {
	require(allowance(Alice, Bob) > 10)
	balances[Alice] -= 10
	allowed[Alice][Bob] -= 10
	balances[Bob] += 10
}
```

1. Alice 授权合约，可向 Bob转账 10 Token；
2. 合约查询 Alice 到 Bob 的配额情况是否大于 Alice 的余额；
3. 合约调整余额表上 Alice 和 Bob 的余额；
4. 合约调整配额表上 Alice 向 Bob 的配额。

### 2.4 协议特点

- 对异常敏感：协议要求对异常情况都进行处理（抛出，回退）

## 03 ERC-20 协议测试



## 04 ERC-20 协议机制分析



## 05 ERC-20 的缺陷

### 5.1 计算问题

### 5.2 授信操作的非原子性

## 06 下周工作 



  