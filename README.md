# contractupdate

控制器合约通过访问数据合约获得数据，并对数据做逻辑处理，然后写回数据合约。它专注于对数据的逻辑处理和对外提供服务。根据处理逻辑的不同，常见的有命名空间控制器合约、代理控制器合约、业务控制器合约、工厂控制器合约等。一般情况下，控制器合约不需要存储任何数据，它完全依赖外部的输入来决定对数据合约的访问。特殊情况下，控制器合约可以存储某个固定的数据合约的地址或者命名空间（通过命名空间在运行时获得合约地址）。

数据合约专注于数据结构定义与所存储数据的读写裸接口。为了达到数据统一访问管理和数据访问权限控制的目的，最好是将数据读写接口只暴露给对应的控制器合约。禁止其他方式的读写访问。

主要是数据合约的迁移，主要有一下三种方式：

### 硬编码迁移
硬编码迁移法指的是，新版本的数据合约中保存一个指向旧版本数据合约的合约地址，新版本数据合约保存的是增量的数据内容。

这样相当于新版本合约保留了一份旧版本数据的指针，当新版本需要使用旧数据的时候，直接调用旧数据合约地址对应数据接口即可。这样，新旧版本数据合约可以并存，即使是在异常情况下，数据被误写到了旧版本合约上，它依然可以被新版本所访问到。

这个方法的优点是：新旧合约可以同时并存，不增加区块链存储压力，简单灵活，较强的升级容错能力。缺点：持续不断的版本升级会导致形成较长的链式逻辑关系，维护成本较高。

### 硬拷贝迁移
将旧数据合约的数据拷贝到链下，然后再从链下存储到新版本合约。

优点：无历史包袱

缺点：增加区块链存储的压力，开发成本高，数据量大

### 默克尔树迁移
1. 利用智能合约语言的面向对象的继承特性，使得新版本合约存储结构完全兼容旧版本合约存储结构。
2. 利用智能合约在区块链上的storage树原理，使得新版本合约的storeage树直接从旧版本合约上衍生。无需显式的迁移过程。
3. 利用区块链交易的原子性，使得新版本合约的部署、数据迁移、升级，原子完成。

这个方法拥有前面两个方法的所有优点，且简单高效，安全，实操性强。缺点：需要区块链底层功能特性的支持。

参考：https://github.com/toxotguo/thinking/blob/master/%E6%B5%85%E8%B0%88%E4%BB%A5%E5%A4%AA%E5%9D%8A%E6%99%BA%E8%83%BD%E5%90%88%E7%BA%A6%E7%9A%84%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F%E4%B8%8E%E5%8D%87%E7%BA%A7%E6%96%B9%E6%B3%95.md#33-%E6%8E%A7%E5%88%B6%E5%99%A8%E5%90%88%E7%BA%A6%E5%8D%87%E7%BA%A7%E6%95%B0%E6%8D%AE%E5%90%88%E7%BA%A6%E5%8D%87%E7%BA%A7