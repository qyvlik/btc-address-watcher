import QtQuick 2.0

import space.qyvlik.utils 1.0

Item {


    Component.onCompleted: {

        var dataList = [];
        var count = 2;
        while(count > 0) {
            dataList.push(count);
            count--;
        }

        Utility.listGroup(dataList, 10, function(list){
            console.log('len:', list.length);
        });

    }


}
