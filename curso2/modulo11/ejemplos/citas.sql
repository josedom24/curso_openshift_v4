use citas;
CREATE TABLE quotes (
	Id int AUTO_INCREMENT NOT NULL,
	quotation varchar(255) NULL,
	author varchar(50) NULL,
	PRIMARY KEY ( Id )
);
INSERT INTO `quotes` VALUES
(1,'Yeah, well, that\'s just like, your opinion, man.','The Dude'),
(2,'It is not only what you do but also the attitude you bring to it, that makes you a success.','Don Schenck'),
(3,'Knowledge is power.','Sir Francis Bacon'),
(4,'Life is really simple, but we insist on making it complicated.','Confucius'),
(5,'This above all: To thine own self be true.','William Shakespeare'),
(6,'I got a fever, and the only prescription is more cowbell.','Will Ferrell'),
(7,'Anyone who has ever made anything of importance was disciplined.','Andrew Hendrixson'),
(8,'Strive not to be a success, but rather to be of value.','Albert Einstein'),
(9,'The greatest glory in living lies not in never falling, but in rising every time we fall.','Nelson Mandela'),
(10,'The way to get started is to quit talking and begin doing.','Walt Disney'),
(11,'Your time is limited so don\'t waste it living someone else\'s life. Don\'t be trapped by dogma – which is living with the results of other people\'s thinking.','Steve Jobs'),
(12,'If life were predictable it would cease to be life, and be without flavor.','Eleanor Roosevelt'),
(13,'If you look at what you have in life you\'ll always have more. If you look at what you don\'t have in life you\'ll never have enough.','Oprah Winfrey'),
(14,'If you set your goals ridiculously high, and it\'s a failure, you will fail above everyone else\'s success.','James Cameron'),
(15,'Life is what happens when you\'re busy making other plans.','John Lennon'),
(16,'The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart.','Helen Keller');
