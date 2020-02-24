module github.com/joshcarp/sysltemplate

go 1.13

replace github.service.anz/sysl/server-lib v0.1.9 => ../../../github.service.anz/sysl/server-lib

require (
	github.com/go-chi/chi v4.0.3+incompatible
	github.com/konsorten/go-windows-terminal-sequences v1.0.2 // indirect
	github.com/lib/pq v1.3.0
	github.com/mattn/go-sqlite3 v2.0.3+incompatible
	github.com/omeid/go-resources v0.0.0-20200113210624-eb442c910d63 // indirect
	github.com/rickb777/date v1.12.4
	github.com/sirupsen/logrus v1.4.2
	github.com/stretchr/testify v1.4.0
	github.service.anz/sysl/server-lib v0.1.9
	golang.org/x/sys v0.0.0-20200217220822-9197077df867 // indirect
)
