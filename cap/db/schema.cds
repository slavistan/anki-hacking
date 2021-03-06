namespace vizn;

using { cuid } from '@sap/cds/common';

type CardType: String enum {
    Basic
}

/* Cards (meta) info - Never modified directly */
entity Cards: cuid {
    type : CardType;
    due : DateTime default CURRENT_TIMESTAMP; // seconds-since-epoch
    t : Integer default 0; // time interval in seconds
    e : Decimal default 2.5; // easyness
    reviews : Composition of many Reviews on reviews.card=$self;
}

entity Reviews {
    key ID : UUID;
    card : Association to Cards not null;
    date : DateTime not null; // date of review
    q : Integer enum { // user response
        inc_hard = 0;  // 0 : blackout
        inc_ok = 1;
        inc_easy = 2;  // 2 : close but no cigar
        corr_hard = 3; // 3 : barely got it right
        corr_ok = 4;
        corr_easy = 5; // 0 : too easy
    } not null;
}

/* Basic cards info - May be modified by the user */
entity ContentBasic {
    key card_ID: UUID;
    front: String;
    back: String;
}