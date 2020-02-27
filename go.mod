module github.service.anz/sysl/sysltemplate

go 1.13

require (
	github.com/go-chi/chi v4.0.3+incompatible
	github.com/rickb777/date v1.12.4
	github.service.anz/sysl/server-lib v0.1.9
)

replace github.service.anz/sysl/server-lib v0.1.9 => github.service.anz/sysl/server-lib v0.1.14-0.20200226044828-77f233d258c8
