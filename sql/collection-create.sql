CREATE TABLE cards (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  command TEXT NOT NULL,
  tags TEXT,
  info TEXT
);

CREATE TABLE schedules (
  cardid INTEGER PRIMARY KEY,
  duesec INTEGER NOT NULL,
  t INTEGER NOT NULL,
  e REAL NOT NULL
);

CREATE TABLE reviews (
  id INTEGER PRIMARY KEY,
  whensec INTEGER NOT NULL,
  q INTEGER NOT NULL
);

CREATE TRIGGER schedule_new_card AFTER INSERT ON cards
BEGIN
  INSERT INTO schedules(cardid, duesec, t, e) VALUES(NEW.id, strftime('%s', 'now'), 0, 2.5);
END;