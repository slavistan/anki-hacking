using { vizn } from '../db/schema.cds';

service CardsService @(path: '/cards') {
    entity Cards as projection on vizn.Cards;
    //entity Schedules as projection on vizn.Schedules;
}