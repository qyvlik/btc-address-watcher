import QtQuick 2.0

import space.qyvlik.sqml 1.0

Item {


    SqlQueryBuilder {
        id: builder
    }

    Component.onCompleted: {
        var dump = builder
        .select(['id', 'name'])
        .from("user")
        .where(function(__builder){
            __builder.inValues('name', ['mike', 'god']);
        }).dump();

        console.log(JSON.stringify(dump));
    }

}
