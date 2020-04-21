namespace vizn;

using { managed } from '@sap/cds/common';

entity Cards {
    key ID : UUID;
    command : String not null;
    schedule : Composition of one Schedules on schedule.card=$self;
    tags : Association to many Tags on tags.ID;
    reviews : Association to many Reviews on reviews.card = $self;
}

entity Schedules {
    key ID : UUID;
    card : Association to Cards;
    due : DateTime default CURRENT_TIMESTAMP; // seconds-since-epoch
    t : Integer default 0; // time interval in seconds
    e : Decimal default 2.5; // easyness
}

entity Tags {
    key ID : UUID;
    tag : String not null;
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