CREATE OR REPLACE TRIGGER hr.secure_employees
  BEFORE INSERT OR UPDATE OR DELETE ON hr.SHOWMETHEMONEY
DISABLE BEGIN
  secure_dml;
END secure_employees;
/