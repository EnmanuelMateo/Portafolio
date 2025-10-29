--Card Holder

CREATE TABLE "card_holder" (
    "id" SERIAL   NOT NULL,
    "first_name" VARCHAR(50)   NOT NULL,
	"last_name" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_card_holder" PRIMARY KEY (
        "id"
     )
);

-- Credit Card

CREATE TABLE "credit_card" (
    "id" VARCHAR(20)   NOT NULL,
    "id_card_holder" INT   NOT NULL,
    CONSTRAINT "pk_credit_card" PRIMARY KEY (
        "id"
     )
);

-- Merchant

CREATE TABLE "merchant" (
    "id" SERIAL   NOT NULL,
    "name" VARCHAR(255)   NOT NULL,
    "id_merchant_category" INT   NOT NULL,
    CONSTRAINT "pk_merchant" PRIMARY KEY (
        "id"
     )
);

-- Merchant Category

CREATE TABLE "merchant_category" (
    "id" SERIAL   NOT NULL,
    "name" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_merchant_category" PRIMARY KEY (
        "id"
     )
);

-- Transaction

CREATE TABLE "transaction" (
    "id" INT   NOT NULL,
    "date" TIMESTAMP   NOT NULL,
    "amount" FLOAT   NOT NULL,
    "card" VARCHAR(20)   NOT NULL,
    "id_merchant" INT   NOT NULL,
    CONSTRAINT "pk_transaction" PRIMARY KEY (
        "id"
     )
);


ALTER TABLE "credit_card" ADD CONSTRAINT "fk_credit_card_id_card_holder" FOREIGN KEY("id_card_holder")
REFERENCES "card_holder" ("id");

ALTER TABLE "credit_card" ADD CONSTRAINT "check_credit_card_length"  CHECK (char_length("id") <= 20);

--ALTER TABLE "credit_card" DROP CONSTRAINT check_credit_card_length

ALTER TABLE "merchant" ADD CONSTRAINT "fk_merchant_id_merchant_category" FOREIGN KEY("id_merchant_category")
REFERENCES "merchant_category" ("id");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_card" FOREIGN KEY("card")
REFERENCES "credit_card" ("id");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_id_merchant" FOREIGN KEY("id_merchant")
REFERENCES "merchant" ("id");


----------------------------------------------------

-- The credit card data came with error on the process. So I will validate and change it with the correct one.
CREATE TEMP TABLE card_mapping (
    old_card VARCHAR(50),
    new_card VARCHAR(50)
);

INSERT INTO card_mapping (old_card, new_card) VALUES
('3517110000000000', '3517111172421930'),
('4761050000000000000', '4761049645711550000'),
('4866760000000000000', '4866761290278190000'),
('675911000000', '675911140852'),
('30078300000000', '30078299053512'),
('4263690000000000', '4263694062533010'),
('584227000000', '584226564303'),
('4276470000000', '4276466390111'),
('4268490000000000', '4268491956169250'),
('3581350000000000', '3581345943543940'),
('4159840000000000000', '4159836738768850000'),
('3516950000000000', '3516952396080240'),
('4539990000000000', '4539990688484980'),
('4834480000000000', '4834483169177060'),
('30063300000000', '30063281385429'),
('30182000000000', '30181963913340'),
('4962920000000000000', '4962915017023700000'),
('4165310000000000000', '4165305432349480000'),
('213194000000000', '213193946980303'),
('180099000000000', '180098539019105'),
('4644010000000000000', '4644008655884310000'),
('4027910000000000', '4027907156459090'),
('501880000000', '501879657465'),
('5297190000000000', '5297187379298980'),
('376028000000000', '376027549341849'),
('4711770000000000', '4711773125020490'),
('5135840000000000', '5135837688671490'),
('3561950000000000', '3561954487988600'),
('5175950000000000', '5175947111814770'),
('4723780000000000000', '4723783028106080000'),
('6500240000000000', '6500236164848270'),
('503843000000', '503842928916'),
('5570600000000000', '5570600642865850'),
('5500710000000000', '5500708021555300'),
('6011990000000000', '6011987562414060'),
('4498000000000', '4498002758300'),
('344120000000000', '344119623920892'),
('4743200000000000000', '4743204091443100000'),
('5361780000000000', '5361779664174550'),
('3561070000000000', '3561072557118690'),
('3535650000000000', '3535651398328200'),
('4506410000000000', '4506405265172170'),
('4586960000000000000', '4586962917519650000'),
('4279100000000000000', '4279104135293220000'),
('501809000000', '501809222273'),
('4741040000000', '4741042733274'),
('4188160000000000', '4188164051171480'),
('4150720000000000', '4150721559116770'),
('4681900000000', '4681896441519'),
('30143000000000', '30142966699187'),
('3582200000000000', '3582198969197590'),
('4319650000000', '4319653513507'),
('372415000000000', '372414832802279');

UPDATE credit_card AS c
SET id = m.new_card
FROM card_mapping AS m
WHERE c.id = m.old_card;

------------------------------------------------ 


SELECT * FROM transaction

SELECT * FROM merchant;

SELECT * FROM card_holder;

SELECT * FROM 

-- VIEW
CREATE VIEW card_holder_identifier AS
SELECT ch.id,
    ch.first_name,
    ch.last_name,
    cc.id AS card_number,
    cc.id_card_holder
   FROM card_holder ch
     LEFT JOIN credit_card cc ON ch.id = cc.id_card_holder;

-- View 2
CREATE VIEW transaction_customer AS
 SELECT t.id AS transaction_id,
    t.date,
    t.amount,
    t.card,
    (cc.first_name::text || ' '::text) || cc.last_name::text AS card_holder
   FROM transaction t
     FULL JOIN card_holder_identifier cc ON t.card::text = cc.card_number::text
  ORDER BY t.amount DESC;

-- Count transactions less than $2.00 per cardholder to check for hacked cards
CREATE OR REPLACE VIEW view_count_transaction_per_cardholder AS
SELECT COUNT(transaction_id) as count_transactions, SUM(amount) as amount_total, card_holder FROM transaction_customer
WHERE amount < 2
GROUP BY card_holder;

-- Identify the top 5 merchants prone to being hacked with small transactions
CREATE OR REPLACE VIEW view_top_merchants AS
SELECT COUNT(t.id) as count_transactions, SUM(amount) as total_amount,  m.name as merchant_name FROM transaction t
LEFT JOIN merchant m
ON t.id_merchant = m.id
WHERE amount < 2
GROUP BY m.name
ORDER BY total_amount DESC
LIMIT(5);

-- Find the top 100 highest transactions during early morning hours (7-9 AM)
CREATE OR REPLACE VIEW view_highest_transactions_7_9 AS
SELECT * FROM transaction t
WHERE EXTRACT(HOUR FROM date) BETWEEN 7 AND 9
ORDER BY date DESC
LIMIT(100);



