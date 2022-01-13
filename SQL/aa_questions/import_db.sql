PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_follows;

DROP TABLE IF EXISTS question_likes;

DROP TABLE IF EXISTS replies;

DROP TABLE IF EXISTS questions;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255)
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body TEXT,
  author_id VARCHAR(255),
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Patricia', 'Williams'),
  ('Kevin', 'Young');

INSERT INTO
  questions (title, body, author_id)
VALUES
  (
    'How to create composite primary keys in SQLite',
    'See title.',
    1
  ),
  (
    'How to count unique rows in SQL',
    "I'm using SQLite.",
    2
  ),
  ('Good SQL exercise websites?', 'See title.', 1);

INSERT INTO
  replies (question_id, user_id, body)
VALUES
  (
    1,
    2,
    "for sqlite, 'PRIMARY KEY (col1, col2, ...)'"
  );

INSERT INTO
  replies (question_id, user_id, parent, body)
VALUES
  (1, 1, 1, "yep");

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (1, 1),
  (1, 2),
  (2, 1),
  (3, 2);

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (2, 1),
  (3, 2);