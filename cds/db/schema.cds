namespace vizn;

using { managed } from '@sap/cds/common';

entity Cards {
    key ID : UUID;
    command : String not null;
    schedule : Association to Schedules on schedule.card = $self;
    tags : Association to many Tags on tags.ID;
    reviews : Association to many Reviews on reviews.card = $self;
}

entity Schedules {
    key ID : UUID;
    card : Association to Cards not null;
    due : DateTime not null default CURRENT_TIMESTAMP; // seconds-since-epoch
    t : Integer not null default 0; // time interval in seconds
    e : Decimal not null default 2.5; // easyness
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