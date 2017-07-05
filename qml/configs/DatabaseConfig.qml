import space.qyvlik.sqml 1.0


DatabaseConnection {
    id: databaseConnection
    identifier: "BTCADDRESSWATCHER"
    version: "1.0"
    description: "BTC ADDRESS WATCHER"
    estimatedSize: 1000 * 1000
    debug: false

    //@override
    function initDatabase(db) {
        console.info("initDatabase: ", identifier, ", start");

        function exec(sql) {
            db.transaction(function(tx){
                try {
                    var resultList = tx.executeSql(sql);
                    console.info("initDatabase:", identifier
                                 ,", resultList lenght : ", resultList.rows.length
                                 , " rowsAffected : ", resultList.rowsAffected
                                 , " insertId : ", resultList.insertId);
                } catch(e) {
                    console.error("initDatabase:", identifier, " fail : error:"
                                  , e, ", __initDatabaseSql：", sql);
                }
            });
        }

        for(var iter in __initDatabaseSql) {
            exec(__initDatabaseSql[iter]);
        }

    }

    readonly property var __initDatabaseSql: [
        "CREATE TABLE `listen_btc_address`
(`address` varchar(64) NOT NULL,
  `alias_name` varchar(64) DEFAULT NULL ,
  `balance` bigint(20) DEFAULT NULL ,
  `listen` varchar(1) DEFAULT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`address`)
);",
        "CREATE TABLE `listen_tx_hash`
( `id` integer PRIMARY KEY autoincrement,
  `tx_hash` varchar(64) NOT NULL,
  `address` varchar(64) NOT NULL,
  `receive` varchar(1) NOT NULL,
  `amount` bigint(20) NOT NULL
);"
    ];
}
