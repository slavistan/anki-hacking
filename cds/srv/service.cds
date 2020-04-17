using { vizn } from '../db/schema.cds';

service CardsService {
    entity Cards as projection on vizn.Cards;
}