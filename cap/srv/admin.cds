using { vizn } from '../db/schema.cds';

service Admin @(path: '/admin') {
    entity Cards as projection on vizn.Cards;
    entity Reviews as projection on vizn.Reviews;
    entity ContentBasic as projection on vizn.ContentBasic;
}