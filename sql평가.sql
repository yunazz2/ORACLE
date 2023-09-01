CREATE TABLE "user" (
	"Key"	VARCHAR2(20)		NOT NULL,
	"user_pw"	VARCHAR2(20)		NULL,
	"user_name"	VARCHAR2(20)		NULL,
	"user_point"	NUMBER		NULL,
	"user_level"	VARCHAR2(20)		NULL,
	"email"	VARCHAR2(30)		NULL
);

CREATE TABLE "ticket" (
	"ticket_num"	NUMBER		NOT NULL,
	"start_point"	VARCHAR2(20)		NULL,
	"start_time"	DATE		NULL,
	"end_point"	VARCHAR2(20)		NULL,
	"end_time"	DATE		NULL,
	"seat_num"	VARCHAR2(20)		NULL,
	"airline_name"	VARCHAR2(20)		NOT NULL,
	"Key"	VARCHAR2(20)		NOT NULL
);

CREATE TABLE "seat" (
	"seat_num"	VARCHAR2(20)		NOT NULL,
	"seat_level"	VARCHAR2(20)		NULL,
	"ticket_num"	NUMBER		NOT NULL
);

CREATE TABLE "airline" (
	"airline_name"	VARCHAR2(20)		NOT NULL,
	"nationality"	VARCHAR2(50)		NULL,
	"aircraft"	VARCHAR2(20)		NULL,
	"destination"	VARCHAR2(30)		NULL,
	"hompage"	VARCHAR2(300)		NULL
);

ALTER TABLE "user" ADD CONSTRAINT "PK_USER" PRIMARY KEY (
	"Key"
);

ALTER TABLE "ticket" ADD CONSTRAINT "PK_TICKET" PRIMARY KEY (
	"ticket_num"
);

ALTER TABLE "seat" ADD CONSTRAINT "PK_SEAT" PRIMARY KEY (
	"seat_num"
);

ALTER TABLE "airline" ADD CONSTRAINT "PK_AIRLINE" PRIMARY KEY (
	"airline_name"
);

ALTER TABLE "ticket" ADD CONSTRAINT "FK_airline_TO_ticket_1" FOREIGN KEY (
	"airline_name"
)
REFERENCES "airline" (
	"airline_name"
);

ALTER TABLE "ticket" ADD CONSTRAINT "FK_user_TO_ticket_1" FOREIGN KEY (
	"Key"
)
REFERENCES "user" (
	"Key"
);

ALTER TABLE "seat" ADD CONSTRAINT "FK_ticket_TO_seat_1" FOREIGN KEY (
	"ticket_num"
)
REFERENCES "ticket" (
	"ticket_num"
);

