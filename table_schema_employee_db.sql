-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "department" (
    "dept_id" TEXT   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_department" PRIMARY KEY (
        "dept_id"
     )
);

CREATE TABLE "position_title" (
    "title_id" TEXT   NOT NULL,
    "title_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_position_title" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "employee" (
    "emp_id" INTEGER   NOT NULL,
    "title_id" VARCHAR   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_employee" PRIMARY KEY (
        "emp_id"
     )
);

CREATE TABLE "dept_employee" (
    "emp_id" INTEGER   NOT NULL,
    "dept_id" VARCHAR   NOT NULL
);

CREATE TABLE "manager" (
    "dept_id" TEXT   NOT NULL,
    "emp_id" INTEGER   NOT NULL,
    CONSTRAINT "pk_manager" PRIMARY KEY (
        "emp_id"
     )
);

CREATE TABLE "salary" (
    "emp_id" INTEGER   NOT NULL,
    "salary_amount" DECIMAL   NOT NULL,
    CONSTRAINT "pk_salary" PRIMARY KEY (
        "emp_id"
     )
);

ALTER TABLE "employee" ADD CONSTRAINT "fk_employee_title_id" FOREIGN KEY("title_id")
REFERENCES "position_title" ("title_id");

ALTER TABLE "dept_employee" ADD CONSTRAINT "fk_dept_employee_emp_id" FOREIGN KEY("emp_id")
REFERENCES "employee" ("emp_id");

ALTER TABLE "dept_employee" ADD CONSTRAINT "fk_dept_employee_dept_id" FOREIGN KEY("dept_id")
REFERENCES "department" ("dept_id");

ALTER TABLE "manager" ADD CONSTRAINT "fk_manager_dept_id" FOREIGN KEY("dept_id")
REFERENCES "department" ("dept_id");

ALTER TABLE "manager" ADD CONSTRAINT "fk_manager_emp_id" FOREIGN KEY("emp_id")
REFERENCES "employee" ("emp_id");

ALTER TABLE "salary" ADD CONSTRAINT "fk_salary_emp_id" FOREIGN KEY("emp_id")
REFERENCES "employee" ("emp_id");

