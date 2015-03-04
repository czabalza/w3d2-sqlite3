DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS questions_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions_likes;

CREATE TABLE users (
  id INTEGER primary key,
  fname VARCHAR(15) NOT NULL,
  lname VARCHAR(15) NOT NULL
);

CREATE TABLE questions (
  id INTEGER primary key,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  author_id INTEGER NOT NULL REFERENCES users(id)
);

CREATE TABLE questions_follows (
  id INTEGER primary key,
  question_id INTEGER NOT NULL REFERENCES questions(id),
  user_id INTEGER NOT NULL REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER primary key,
  body VARCHAR(255) NOT NULL,
  question_id INTEGER NOT NULL REFERENCES questions(id),
  parent_id INTEGER REFERENCES replies(id),
  user_id INTEGER REFERENCES users(id)
);

CREATE TABLE questions_likes (
  id INTEGER primary key,
  question_id INTEGER NOT NULL REFERENCES questions(id),
  user_id INTEGER NOT NULL REFERENCES users(id)
);

INSERT INTO
 users
 (fname, lname)
VALUES
 ('bob', 'marley'), ('janice', 'joplin'), ('justin', 'beiber');

INSERT INTO
 questions
 (title, body, author_id)
VALUES
 ('weed', 'where can i find the green?', 1),
 ('countries', 'is paris in england or london', 3);

INSERT INTO
 replies
 (body, question_id, parent_id, user_id)
VALUES
 ('france, dumbass', 2, null, 2),
 ('in my bed', 1, null, 2),
 ('youre obviously not a belieber', 2, 1, 3);

INSERT INTO
  questions_follows
  (question_id, user_id)
VALUES
  (1, 2),
  (1, 3);
