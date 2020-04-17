namespace vizn;

entity Cards {
    key ID : UUID;
    command : String not null;
    schedule : Association to Schedules on schedule.card = $self;
    tags : Association to many Tags;
    reviews : Association to many Reviews on reviews.card = $self;
}

entity Schedules {
    key ID : UUID;
    card : Association to Cards not null;
    due : DateTime not null; // seconds-since-epoch
    t : Integer not null; // time interval
    e : Decimal not null; // easyness
}

entity Tags {
    key ID : UUID;
    tag : String not null;
}

entity Reviews {
    key ID : UUID;
    card : Association to Cards not null;
    date : DateTime not null;
    q : Integer enum {
        inc_hard = 0;  // 0 : blackout
        inc_ok = 1;
        inc_easy = 2;  // 2 : close but no cigar
        corr_hard = 3; // 3 : barely got it right
        corr_ok = 4;
        corr_easy = 5; // 0 : too easy
    } not null;
}