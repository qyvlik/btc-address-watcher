import space.qyvlik.sqml 1.0


/**
CREATE TABLE `listen_tx_hash` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tx_hash` varchar(64) NOT NULL COMMENT '交易 hash',
  `address` varchar(64) NOT NULL COMMENT '地址',
  `receive` varchar(1) NOT NULL COMMENT '1 为收币，0 为发币',
  `amount` bigint(20) NOT NULL COMMENT '币数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
*/

SqlMapping {
    id: listenTxHashDao

    //@override
    function get(entity) {

        sqlQueryBuilder.select(['id', 'tx_hash', 'address', 'receive', 'amount'])
        .from('listen_tx_hash');

        if(stringNotEmpty(entity.address)) {
            sqlQueryBuilder.where();
            sqlQueryBuilder.equals('address', entity.address);
        }

        return sqlQueryBuilder.dump();
    }

    //@override
    function getByEntity(entity) {
        return get(entity);
    }

    //@override
    function findList(entity) {

        sqlQueryBuilder.select(['id', 'tx_hash', 'address', 'receive', 'amount'])
        .from('listen_tx_hash');

        if(stringNotEmpty(entity.address)) {
            sqlQueryBuilder.where();
            sqlQueryBuilder.equals('address', entity.address);
        }

        return sqlQueryBuilder.dump();
    }

    //@override
    function insert(entity) {
        sqlQueryBuilder.insertInto('listen_tx_hash',
                                   ['tx_hash', 'address', 'receive', 'amount'],
                                   [entity.txHash, entity.address, entity.receive, entity.amount]);

        return sqlQueryBuilder.dump();
    }

    //@override
    function insertList(list) {
        var bindList = [];
        for(var iter in list) {
            var entity = list[iter];
            var bind = [entity.txHash, entity.address, entity.receive, entity.amount];
            bindList.push(bind)
        }

        sqlQueryBuilder.insertMutilValues('listen_tx_hash',
                                   ['tx_hash', 'address', 'receive', 'amount'],
                                   bindList);

        return sqlQueryBuilder.dump();
    }

    //@override
    function update(entity) {
        return {
            sql: "",
            bind: []
        };
    }

    //@override
    function deleteById(entity) {
        sqlQueryBuilder.deleteFrom('listen_tx_hash')
        .where()
        .equals('id', entity.id);

        return sqlQueryBuilder.dump();
    }

    //@override
    function deleteRecord(entity) {
        return deleteById(entity)
    }
}
