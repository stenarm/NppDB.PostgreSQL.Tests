DROP TABLE IF EXISTS project CASCADE;

CREATE TABLE project (
id SMALLINT NOT NULL DEFAULT 0,
points SMALLINT NOT NULL DEFAULT 0,
CONSTRAINT pk_project PRIMARY KEY (id));

CREATE OR REPLACE FUNCTION f_register_result (p_points project.points % TYPE) 
RETURNS VOID 
LANGUAGE SQL SECURITY DEFINER
SET search_path = PUBLIC 
BEGIN ATOMIC
	INSERT INTO project AS p (points)
	VALUES (p_points) ON CONFLICT (id) DO
	UPDATE
	SET points = EXCLUDED.points
	WHERE p.id = 0; 
END;

INSERT INTO project (id, points) VALUES (0, 30);

SELECT * FROM project;

SELECT f_register_result (
p_points:=35::SMALLINT
);