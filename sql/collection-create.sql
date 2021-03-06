/* Cards - Essential table */
CREATE TABLE cards (
  cardid INTEGER PRIMARY KEY AUTOINCREMENT,
  command TEXT NOT NULL
);

/* Scheduling information for every card - Essential table */
CREATE TABLE schedules (
  cardid INTEGER PRIMARY KEY,
  duesec INTEGER NOT NULL,
  t INTEGER NOT NULL,
  e REAL NOT NULL,
  FOREIGN KEY(cardid) REFERENCES cards(cardid)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  cardid INTEGER NOT NULL,
  tag TEXT NOT NULL,
  FOREIGN KEY(cardid) REFERENCES cards(cardid)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE reviews (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  cardid INTEGER NOT NULL,
  whensec INTEGER NOT NULL,
  q INTEGER NOT NULL,
  FOREIGN KEY(cardid) REFERENCES cards(cardid)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TRIGGER schedule_new_card AFTER INSERT ON cards
BEGIN
  INSERT INTO schedules(cardid, duesec, t, e) VALUES(NEW.cardid, strftime('%s', 'now'), 0, 2.5);
END;
