USE ig_clone;
-- A) Marketing:
-- 1) 5 oldest users of Instagram from the database
SELECT 
    *
FROM
    users
ORDER BY created_at ASC
LIMIT 5;

-- 2) Users who have never posted a single photo on Instagram

SELECT 
    users.id,
    users.username
FROM
    users
        LEFT JOIN
    photos ON users.id = photos.user_id
WHERE
    photos.image_url IS NULL;
    
-- 3) User who gets the most likes on a single photo

SELECT 
    photos.user_id,
    users.username,
    likes.photo_id,
    photos.image_url,
    photos.created_dat,
    COUNT(*) AS no_of_likes
FROM
    photos
        INNER JOIN
    likes ON likes.photo_id = photos.id
        INNER JOIN
    users ON photos.user_id = users.id
GROUP BY likes.photo_id
ORDER BY no_of_likes DESC
LIMIT 1;

-- 4) Top 5 most commonly used hashtags on the platform

SELECT 
	tags.id AS tag_id,
    tags.tag_name,
    count(*) as No_of_times_used
FROM photo_tags
JOIN tags ON photo_tags.tag_id = tags.id
GROUP BY photo_tags.tag_id
ORDER BY No_of_times_used DESC
limit 10;

-- 5) The best day to launch ADs

SELECT
DAYNAME(created_at) as day_of_registration,
COUNT(*) as no_of_users_registered FROM users
GROUP BY day_of_registration;

-- B) Investor Metrics:
-- 1) Average user posts on Instagram

SELECT (SELECT
COUNT(id) FROM
photos) / (SELECT
COUNT(id) FROM
users) AS average_post_per_user;

--  2) Users (bots) who have liked every single photo on the site

SELECT
users.id,
users.username,
COUNT(*) AS no_of_photo_liked
FROM
likes
INNER JOIN
users ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING no_of_photo_liked = (SELECT
COUNT(*) FROM
photos)


