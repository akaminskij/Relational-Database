SELECT * FROM users LIMIT 10;
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;

SELECT * FROM profiles LIMIT 10;
UPDATE profiles SET gender = "F" WHERE gender = "W";
UPDATE profiles SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE profiles SET last_login = NOW() WHERE last_login < updated_at;

CREATE TEMPORARY TABLE genders(name CHAR(1));
INSERT INTO genders VALUES ('F'), ('M');

SELECT * FROM genders;
SELECT name FROM genders ORDER BY RAND() LIMIT 1;
UPDATE profiles SET gender = (SELECT name FROM genders ORDER BY RAND() LIMIT 1);

SELECT * FROM messages LIMIT 10;
SELECT FLOOR(1 + RAND() * 100);

UPDATE messages SET
  from_user_id = FLOOR(1 + RAND() * 100),
  to_user_id = FLOOR(1 + RAND() * 100);
  
SELECT * FROM media LIMIT 10;
UPDATE media SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE media SET user_id = FLOOR(1 + RAND() * 100);

CREATE TEMPORARY TABLE extensions (name VARCHAR(10));
INSERT INTO extensions VALUES ('jpeg'), ('mp4'), ('mp3'), ('avi'), ('png');
SELECT * FROM extensions;
 
UPDATE media SET filename = CONCAT(
  'http://vk.com/media/',
  filename,
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1));
  
UPDATE media SET size = FLOOR(12000 + (RAND() * 1000000)) WHERE size < 10000;
 
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}'); 
  
SELECT * FROM media_types;
UPDATE media_types SET updated_at = NOW() WHERE updated_at < created_at;
 
SELECT * FROM friendship LIMIT 10;
UPDATE friendship SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE friendship SET updated_at = NOW() WHERE requested_at < confirmed_at;
ALTER TABLE friendship DROP PRIMARY KEY;

UPDATE friendship SET
  user_id = FLOOR(1 + RAND() * 100),
  friend_id = FLOOR(1 + RAND() * 100);
 
SELECT * FROM friendship_statuses;
UPDATE friendship_statuses SET updated_at = NOW() WHERE updated_at < created_at;
TRUNCATE friendship_statuses;
INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');

UPDATE friendship SET friendship_status_id = FLOOR(1 + RAND() * 3); 
  
SELECT * FROM communities;
UPDATE communities SET updated_at = NOW() WHERE updated_at < created_at;

SELECT * FROM communities_users;