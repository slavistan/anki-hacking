using { vizn } from '../db/schema.cds';

service Developer @(path: '/developer') {
    /* Generate cards for a given card type */
    function generate(type: vizn.CardType, n: Integer) returns Integer;
}

 //entity Cards: cuid {
 //    type : CardType;
 //    due : DateTime default CURRENT_TIMESTAMP; // seconds-since-epoch
 //    t : Integer default 0; // time interval in seconds
 //    e : Decimal default 2.5; // easyness
 //    reviews : Composition of many Reviews on reviews.card=$self;
 //}