import space.qyvlik.sqml 1.0


/**
CREATE TABLE `listen_btc_address` (
  `address` varchar(64) NOT NULL COMMENT '比特币地址',
  `alias_name` varchar(64) DEFAULT NULL COMMENT '地址别名',
  `balance` bigint(20) DEFAULT NULL COMMENT '地址余额',
  `listen` varchar(1) DEFAULT NULL COMMENT '1 为监听，0为不监听',
  `create_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`address`)
);
*/

SqlMapping {
    id: listenBtcAddressDaoMapping

    //@override
    function get(entity) {

        sqlQueryBuilder.select(['address', 'alias_name', 'balance', 'listen', 'create_time'])
        .from('listen_btc_address');

        sqlQueryBuilder.where(function(builder){
            if(stringNotEmpty(entity.address)) {
                builder.equals('address', entity.address);
            }
        });

        return sqlQueryBuilder.dump();
    }

    //@override
    function getByEntity(entity) {
        return get(entity);
    }

    //@override
    function findList(entity) {

        sqlQueryBuilder.select(['address', 'alias_name', 'balance', 'listen', 'create_time'])
        .from('listen_btc_address')
        .where(function(builder){

            if(stringNotEmpty(entity.address)) {
                builder.equals('address', entity.address);
            }

            if(stringNotEmpty(entity.aliasName)) {
                builder.equals('alias_name', entity.aliasName);
            }

            if(stringNotEmpty(entity.listen)) {
                builder.equals('listen', entity.listen);
            }
        })
        .orderBy(['create_time']);

        return sqlQueryBuilder.dump();
    }

    //@override
    function insert(entity) {
        sqlQueryBuilder.insertInto('listen_btc_address',
                                   ['address', 'alias_name', 'balance', 'listen', 'create_time'],
                                   [entity.address, entity.aliasName, entity.balance, entity.listen, entity.createTime]);

        return sqlQueryBuilder.dump();
    }

    //@override
    function update(entity) {
        sqlQueryBuilder.update('listen_btc_address', {
                                   'balance': entity.balance
                               })
        .where()
        .equals('address', entity.address);

        return sqlQueryBuilder.dump();
    }

    //@override
    function deleteById(entity) {
        sqlQueryBuilder.deleteFrom('listen_btc_address')
        .where()
        .equals('address', entity.address);

        return sqlQueryBuilder.dump();
    }

    //@override
    function deleteRecord(entity) {
        return deleteById(entity)
    }
}
