/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        排行榜模块集合
*/
define(['backbone', 'jquery', 'mgc_ranklist_model', 'mgc_consts'], function(backbone, $, ranklist_model, consts) {
    var ranklist_coll = {};
    ranklist_coll.RankItemColl = backbone.Collection.extend({
        model: ranklist_model.RankItemModel,
        initialize: function(models) {
            if (models) {
                this.reset(models);
            }
        },
        rankExchange: ['first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth', 'ninth', 'tenth', '', '', ''],
        reset_rank_list: function(data, maxlen, begin_index, isextend) {
            if (data && data.length > 0) {
                var list = [];
                for (var i = 0; i < data.length; i++) {
                    if (i >= maxlen) {
                        break;
                    }
                    if (data[i].isExtend == undefined) {
                        data[i].no = begin_index + 1;
                        if (begin_index < maxlen) {
                            data[i].noStr = this.rankExchange[i];
                        } else {
                            data[i].noStr = "";
                        }
                        data[i].isExtend = false;
                    }                    
                    var RankItemModel = new ranklist_model.RankItemModel();
                    RankItemModel.set_data(data[i]);
                    list.push(RankItemModel);
                    begin_index++;
                }
                if (!isextend) {
                    for (var i = data.length; i < maxlen; i++) {
                        data[i] = [];
                        data[i].no = begin_index + 1;
                        if (begin_index < maxlen) {
                            data[i].noStr = this.rankExchange[i];
                        } else {
                            data[i].noStr = "";
                        }
                        data[i].isExtend = true;
                        var RankItemModel = new ranklist_model.RankItemModel();
                        RankItemModel.set_data(data[i]);
                        list.push(RankItemModel);
                        begin_index++;
                    }
                }
                this.reset(list);
            }
            else {
                this.reset();
            }
        }
    });
    return ranklist_coll;
});