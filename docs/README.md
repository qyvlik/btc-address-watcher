# docs

## database

```
CREATE TABLE `listen_btc_address` (
  `address` varchar(64) NOT NULL COMMENT '比特币地址',
  `alias_name` varchar(64) DEFAULT NULL COMMENT '地址别名',
  `balance` bigint(20) DEFAULT NULL COMMENT '地址余额',
  `listen` varchar(1) DEFAULT NULL COMMENT '1 为监听，0为不监听',
  `create_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

```
CREATE TABLE `listen_tx_hash` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tx_hash` varchar(64) NOT NULL COMMENT '交易 hash',
  `address` varchar(64) NOT NULL COMMENT '地址',
  `receive` varchar(1) NOT NULL COMMENT '1 为收币，0 为发币',
  `amount` bigint(20) NOT NULL COMMENT '币数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```
