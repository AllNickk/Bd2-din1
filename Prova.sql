CREATE TABLE empregados (
 emp_id int NOT NULL,
 dep_id int DEFAULT NULL,
 supervisor_id int DEFAULT NULL,
 nome varchar(255) DEFAULT NULL,
 salario int DEFAULT NULL,
 PRIMARY KEY (emp_id)
);

CREATE TABLE departamentos (
 dep_id int NOT NULL ,
 nome varchar(255) DEFAULT NULL,
 PRIMARY KEY (dep_id)
);


INSERT INTO empregados (emp_id, dep_id, supervisor_id, nome, salario)
VALUES
 (1,1,0,'Jose','8000'),
	(2,3,5,'Joao','6000'),
	(3,1,1,'Guilherme','5000'),
	(4,1,1,'Maria','9500'),
	(5,2,0,'Pedro','7500'),    
    (6,1,1,'Claudia','10000'),
    (7,4,1,'Ana','12200'),
    (8,2,5,'Luiz','8000');

INSERT INTO departamentos (dep_id, nome)
VALUES
	(1,'TI'),
	(2,'RH'),
	(3,'Vendas'),
	(4,'Marketing');




--4
SELECT d.nome, AVG(e.salario) AS media_salario
FROM departamentos AS d
INNER JOIN empregados AS e ON e.dep_id = d.dep_id
GROUP BY d.nome
HAVING AVG(e.salario) = (SELECT MIN(media_salario)
FROM (SELECT AVG(e.salario) AS media_salario FROM departamentos AS d INNER JOIN empregados AS e ON e.dep_id = d.dep_id GROUP BY d.nome) AS t)

--3
SELECT d.dep_id, d.nome, COUNT(e.emp_id) AS qtd_funcionarios
FROM departamentos AS d
INNER JOIN empregados AS e ON e.dep_id = d.dep_id
WHERE e.salario >= (SELECT AVG(salario) FROM empregados AS e2 WHERE e2.dep_id = d.dep_id)
GROUP BY d.dep_id, d.nome

--2
SELECT e1.emp_id, e1.nome, SUM(e2.salario) AS soma_salario_subordinados
FROM empregados AS e1
INNER JOIN empregados AS e2 ON e2.supervisor_id = e1.emp_id
GROUP BY e1.emp_id, e1.nome
HAVING SUM(e2.salario) > (SELECT AVG(salario) FROM empregados AS e3 WHERE e3.supervisor_id = e1.emp_id)
