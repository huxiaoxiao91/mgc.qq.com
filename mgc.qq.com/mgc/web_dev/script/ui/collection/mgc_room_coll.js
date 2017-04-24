/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        room模块集合
*/
define(['backbone', 'jquery', 'mgc_room_model'], function (backbone, $, room_model) {
    var room_coll = {};

    //@todo

    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.room_coll = room_coll;
    return room_coll;
});